class Attachment < ActiveRecord::Base
  belongs_to :uploaded_file
  belongs_to :attachable, :polymorphic => true
  
  validates_presence_of :uploaded_file_id
  validate :add_errors_from_uploaded_file
  
  after_destroy :destroy_uploaded_file
  
  def add_errors_from_uploaded_file
    unless uploaded_file.valid?
      for attribute, msg in uploaded_file.errors
        if attribute == "size" && msg == "is not included in the list"
          errors.add("size", "is too big")
        else
          errors.add(attribute, msg)
        end
      end
    end
  end
  
  def destroy_uploaded_file
    uploaded_file.destroy if uploaded_file.attachments.empty?
  end
end
