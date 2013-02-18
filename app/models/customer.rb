class Customer < ActiveRecord::Base

  validates_presence_of :reference
  validates_uniqueness_of :reference
  belongs_to :country
  has_many :orders
  has_many :size_charts
  has_many :size_chart_specifications,
           :class_name => "SizeChart",
           :conditions => { :specification => true },
           :order => 'department_id'
  
  has_many :warehouses
  has_many :dispatches, :through => :orders
  
  has_many :users

  has_many :roles, :as => :company
  has_many :people, :through => :roles do
    def owner
      find(:first, :conditions => "roles.title = 'Owner'")
    end
  end
  
  after_update :save_roles
  
  def new_role_attributes=(role_attributes)
    role_attributes.each do |attributes|
      roles.build(attributes) unless attributes.values_blank?
    end
  end
  
  def existing_role_attributes=(role_attributes)
    roles.reject(&:new_record?).each do |role|
      attributes = role_attributes[role.id.to_s]
      if attributes
        role.attributes = attributes
      else
        roles.delete(role)
      end
    end
  end
  
  def save_roles
    roles.each do |role|
      role.save(false)
    end
  end
end

