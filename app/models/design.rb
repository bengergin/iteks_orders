class Design < ActiveRecord::Base
  acts_as_solr :additional_fields => [:customer_reference, :taken_or_not, :sampled_or_not, :designer_name, :tag_list]
  belongs_to :customer
  belongs_to :department
  belongs_to :style
  belongs_to :creator, :class_name => "User", :foreign_key => "created_by"
  belongs_to :updater, :class_name => "User", :foreign_key => "updated_by"
  belongs_to :original, :class_name => "Design"
  
  has_many :amendments, :class_name => "Design", :foreign_key => "original_id", :dependent => :nullify
  has_many :packs
  has_many :attachments, :as => :attachable, :dependent => :destroy
  has_many :uploaded_files, :through => :attachments, :dependent => :destroy
  has_many :orders, :through => :packs
  has_many :samples
  
  before_create :save_amendment_number
  validates_presence_of :description
  
  validate :add_errors_from_attachments
  
  after_save :save_reference
  before_save :set_thumbnail_path, :set_full_description
  
  acts_as_taggable
  
  def set_thumbnail_path
    self.thumbnail_path = uploaded_files.first.public_filename(:small) unless uploaded_files.empty?
  end
  
  # Return a placeholder image if there is no thumbnail.
  def thumbnail_path
    self[:thumbnail_path].blank? ? '/images/no_image_yet.gif' : self[:thumbnail_path]
  end
  
  def take!
    if amendment?
      original.take!
      solr_save
    else
      update_attribute(:taken, true)
      amendments.each do |amendment|
        amendment.update_attribute(:taken, true)
      end
    end
  end
  
  def sampled?
    !samples.empty?
  end
  
  def new_reference
    reference = if customer
      "DR-%0.3i/#{customer.reference}" % id
    else
      "DR-%0.3i" % id
    end
    
    new_reference = if amendment?
      dr_number, customer = original.reference.split("/")
      if customer
        "#{dr_number}-AM#{amendment_number}/#{customer}"
      else
        "#{dr_number}-AM#{amendment_number}"
      end
    else
      reference
    end
  end
  
  def save_reference
    update_attribute(:reference, new_reference) if reference != new_reference
  end
  
  def set_full_description
    self.full_description = "#{department.name} #{style.name} #{description}"
  end
   
  def uploaded_files=(attributes)
    for uploaded_file in attributes
      attachments.create(:uploaded_file => UploadedFile.create(uploaded_file))
    end
  end
  
  def clone
    if amendment?
      original.clone
    else
      clone = super
      clone.original_id = id
      clone.tag_list = tag_list
      clone
    end
  end
  
  def amendment?
    original_id?
  end
  
  def save_amendment_number
    self.amendment_number = original.amendments.length + 1 if amendment?
  end
  
  def customer_reference
    customer.reference
  end
  
  def taken_or_not
    "taken" if taken?
  end
  
  def sampled_or_not
    "sampled" if sampled?
  end
  
  def designer_name
    creator.name
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
