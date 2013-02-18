require 'digest/sha1'

class User < ActiveRecord::Base
  include Nameable
  
  # Access permissions for users. Levels are cascading so
  # someone who has write permission (2) can also read (1) but
  # cannot destroy (3).
  cattr_accessor :levels
  @@levels = {
    :read    => 1,
    :write   => 2,
    :destroy => 3
  }
    
  with_options :foreign_key => "created_by" do |user|
    user.has_many :designs
    user.has_many :packagings
  end
  
  has_and_belongs_to_many :customers, :order => "name"
  has_and_belongs_to_many :countries, :order => "name"
  has_and_belongs_to_many :companies, :order => "name"
  has_and_belongs_to_many :departments, :order => "name"
  
  validates_uniqueness_of   :login
  validates_presence_of     :password, :on => :create 
  validates_confirmation_of :password
  
  attr_accessible :login, :password, :first_name, :last_name, :extension, :email,
                  :google_talk, :skype, :password_confirmation, :customer_ids,
                  :company_ids, :mobile_number, :orders_access, :size_charts_access,
                  :designs_access, :samples_access, :packagings_access,
                  :factories_access, :people_access, :warehouses_access, :customers_access,
                  :admin, :telephone, :name, :buying_price, :selling_price,
                  :statistics, :country_ids, :unplaced, :home, :enabled, :contract_date, 
                  :contract, :is_customer, :department_ids, :quality_controls_access,
                  :deleted, :reports_access
  
  attr_accessor :password_confirmation, :password

  named_scope :enabled, :conditions => { :enabled => true }

  before_save :encrypt_password, :deleted_not_enabled
  
  def self.[](first_name, last_name=nil)
    conditions = { :first_name => first_name }
    conditions[:last_name] = last_name if last_name
    find(:first, :conditions => conditions)
  end
  
  # Easy way to query a user's permissions given a verb
  # and object, e.g. @user.can?(:read, :orders)
  def can?(verb, object)
    if admin?
      true
    elsif @@levels.include?(verb) && self["#{object}_access"]
      self["#{object}_access"] >= @@levels[verb]
    end
  end
  
  # Only enabled users can be authenticated.
  def self.authenticate(login, password)
    user = enabled.find_by_login(login)
    if user && user.hashed_password == encrypted_password(password, user.salt)
      user
    end
  end
  
  def orders
    query = if unplaced?
      "(country_id IS NULL OR country_id IN (?)) AND customer_id IN (?) AND company_id IN (?)"
    else
      "country_id IN (?) AND customer_id IN (?) AND company_id IN (?)"
    end
    Order.scoped(:conditions => [query, country_ids, customer_ids, company_ids])
  end
  
  def dispatches
    query = if unplaced?
      "(country_id IS NULL OR country_id IN (?)) AND customer_id IN (?) AND company_id IN (?)"
    else
      "country_id IN (?) AND customer_id IN (?) AND company_id IN (?)"
    end
    Dispatch.scoped(:conditions => [query, country_ids, customer_ids, company_ids])
  end

  def dispatch_quantities
    query = if unplaced?
      "(country_id IS NULL OR country_id IN (?)) AND customer_id IN (?) AND company_id IN (?)"
    else
      "country_id IN (?) AND customer_id IN (?) AND company_id IN (?)"
    end
    DispatchQuantity.scoped(:conditions => [query, country_ids, customer_ids, company_ids])
  end
  
  def customer_designs
    Design.scoped(:conditions => ["customer_id IN (?) AND department_id IN (?) AND taken = ?", customer_ids, department_ids, 0])
  end
  
  def size_charts
    query = "customer_id IN (?)"
    SizeChart.specifications.scoped(:conditions => [query, customer_ids])
  end
  
  def quality_controls
    query = "customer_id IN (?)"
    QualityControl.scoped(:conditions => [query, customer_ids])  
  end
  
  def samples
    query = if unplaced?
      "(country_id IS NULL OR country_id IN (?)) AND customer_id IN (?) AND company_id IN(?)"
    else
      "country_id IN (?) AND customer_id IN (?) AND company_id IN (?)"
    end
    Sample.scoped(:conditions => [query, country_ids, customer_ids, company_ids])
  end
  
  # Allows for user.can_read_orders? instead of user.can?(:read, :orders)
  def method_missing(name, *args, &block)
    if name.to_s[/can_([[:lower:]]+)_([[:lower:]]+)?/]
      can?($1, $2)
    else
      super
    end
  end
  
  private
  
  def encrypt_password
    if !password.blank?
      self.salt = Digest::SHA1.hexdigest("92#{Time.now.to_s}112#{login}*@3") if new_record?
      self.hashed_password = self.class.encrypted_password(password, salt)
    end
  end
  
  def self.encrypted_password(password, salt)
    Digest::SHA1.hexdigest("F*Sad#{password}!(3{)-#{salt}2sDSfS£@")
  end
  
  def deleted_not_enabled
    if deleted == true
      self.enabled = 0
    end
  end
  
end
