class Sample < ActiveRecord::Base
  NEAR = 1
  PERFECT = 2
  SINGLE = 1
  DOUBLE = 2
  SPATULA = 1
  PROFILE = 2
  
	acts_as_solr :fields => [:reference, :full_description, :design_reference], :include => [:customer, :country, :factory] 
  
  belongs_to :customer
  belongs_to :exchange_rate
  belongs_to :department
  belongs_to :style
  belongs_to :design
  belongs_to :size_chart
  belongs_to :factory
  belongs_to :country
  belongs_to :company
  has_many :sample_add_ons, :dependent => :destroy
  has_many :add_ons, :through => :sample_add_ons
  has_and_belongs_to_many :sizes
  belongs_to :creator, :class_name => "User", :foreign_key => "created_by"
  belongs_to :updater, :class_name => "User", :foreign_key => "updated_by"
  
  has_many :attachments, :as => :attachable
  has_many :uploaded_files, :through => :attachments
  
  has_many :sample_statuses
  has_many :sample_sents
  has_many :sample_receiveds
  has_many :sample_rejecteds
  has_many :sample_approveds
  has_many :sample_prices
  has_many :sample_comments
  has_many :sample_completeds
  
  validates_presence_of :customer_id, :department_id, :description, :country_id
  validates_numericality_of :quantity_required
  validate :add_errors_from_attachments
  
  before_save :set_full_description, :set_has_add_ons
  after_update :save_sample_add_ons
  after_save :sample_design
  
  with_options :order => "required_on" do |sample|
    sample.named_scope :incomplete, :conditions => "completed_on IS NULL"
    sample.named_scope :complete, :conditions => "completed_on IS NOT NULL"
  end
  
  named_scope :placed_in, lambda { |country_id,unplaced|
    queries = []
    params  = []
    if unplaced
      queries << "country_id IS NULL"
    end
    if !country_id.blank?
      queries << "country_id IN (?)"
      params << country_id
    end
    { :conditions => [queries.join(" OR "), *params] }
  }
  
  named_scope :is_complete, lambda { |complete| 
    if complete
      { :conditions => "completed_on IS NOT NULL" }
    else
      { :conditions => "completed_on IS NULL" }
    end
  }
  
  named_scope :for, lambda { |customer_id|
    if customer_id.blank?
      {}
    else
      { :conditions => { :customer_id => customer_id } }
    end
  }
  
  named_scope :for_department, lambda { |department_id|
    if department_id.blank?
      {}
    else
      { :conditions => { :department_id => department_id } }
    end
  }
  
  named_scope :by, lambda { |company_id|
   if company_id.blank?
     {}
    else
      { :conditions => { :company_id => company_id } }
    end  
  }
  
  def created_at_d
  	self.created_at
	end

  def design_reference
    design.reference if design
  end 
  
  def design_reference=(reference)
    self.design = unless reference.blank?
      Design.find_by_reference(reference)
    end
  end
  
  def reference
    "SR-%0.3d/#{customer.reference}" % id
  end
  
  def uploaded_files=(attributes)
    for uploaded_file in attributes
      attachments.create(:uploaded_file => UploadedFile.create(uploaded_file))
    end
  end
  
  def match_colour
    case colour_match
    when NEAR then "Near"
    when PERFECT then "Perfect"
    end
  end
  
  def cylinder_type
    case number_of_cylinders
    when SINGLE then "Single"
    when DOUBLE then "Double"
    end
  end
  
  def sock_forming
    case forming
    when SPATULA then "Spatula"
    when PROFILE then "Profile"
    end
  end
  
  def looping_check
    looping_check_required ? "Yes" : "No"
  end
  
  def new_sample_add_on_attributes=(sample_add_on_attributes)
    sample_add_on_attributes.each do |attributes|
      unless attributes.values_blank?
        sample_add_ons.build(:quantity => attributes[:quantity], :price_gbp => attributes[:price_gbp], :price_eur => attributes[:price_eur], :price_usd => attributes[:price_usd]).add_on = AddOn.find_or_initialize_by_description_and_reference(attributes[:description], attributes[:reference])
      end
    end
  end
  
  def existing_sample_add_on_attributes=(sample_add_on_attributes)
    sample_add_ons.reject(&:new_record?).each do |sample_add_on|
      attributes = sample_add_on_attributes[sample_add_on.id.to_s]
      if attributes && !attributes[:quantity].blank?
        sample_add_on.quantity = attributes[:quantity]
        sample_add_on.price_gbp = attributes[:price_gbp]
        sample_add_on.price_eur = attributes[:price_eur]
        sample_add_on.price_usd = attributes[:price_usd]
        sample_add_on.add_on = AddOn.find_or_initialize_by_description_and_reference(attributes[:description], attributes[:reference])
      else
        sample_add_ons.delete(sample_add_on)
      end
    end
  end
  
  def save_sample_add_ons
    sample_add_ons.each do |sample_add_on|
      sample_add_on.save(false)
    end
  end
  
  def received_on
    completed_on
  end
  
  private
  
  def sample_design
    design.try(:solr_save)
  end
  
  def set_full_description
    self.full_description = "#{department.name} #{style.name} #{description}"
  end
  
  def set_has_add_ons
    self.has_add_ons = !sample_add_ons.empty?
    true
  end
  
  def add_errors_from_attachments
    for attachment in attachments
      unless attachment.valid?
        for attribute, msg in attachment.errors
          errors.add(attribute, msg)
        end
      end
    end
  end
end
