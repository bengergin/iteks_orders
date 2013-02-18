class QualityControl < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  
  has_many :attachments, :as => :attachable
  has_many :uploaded_files, :through => :attachments
  has_many :dispatches

  validate :add_errors_from_attachments
  
  validates_presence_of :order_id, :total_quantity, :quantity_checked, :major_faults, :minor_faults
  validates_numericality_of :total_quantity, :quantity_checked, :major_faults, :minor_faults
  
  before_save :write_customer_id, :write_department_id
  after_save :save_dispatches
  

  named_scope :specifications, :conditions =>  { :specification => true }
  named_scope :for, lambda { |customer_ids|
    if customer_ids.blank?
      {}
    else
      { :conditions => { :customer_id => customer_ids } }
    end
  }
  
  named_scope :for_department, lambda { |department_id|
    if department_id.blank?
      {}
    else
      { :conditions => { :department_id => department_id } }
    end
  }
  
  def pass_or_fail
    pass_fail ? "Pass" : "Fail"
  end
  
  def write_customer_id
    self.customer_id = order.customer_id
  end
  
  def write_department_id
    self.department_id = order.department_id
  end
  
  def percentage_checked
    (quantity_checked.to_f / total_quantity.to_f) * 100
  end
  
  def minor_faults_percentage
    (minor_faults.to_f / quantity_checked.to_f) * 100
  end
  
  def major_faults_percentage
    (major_faults.to_f / quantity_checked.to_f) * 100
  end
  
  def uploaded_files=(attributes)
    for uploaded_file in attributes
      attachments.create(:uploaded_file => UploadedFile.create(uploaded_file))
    end
  end
  
  def save_dispatches
    if order
      order.dispatches.each { |dispatch| dispatch.save(false) }
    end
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