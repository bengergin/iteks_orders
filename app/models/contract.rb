class Contract < ActiveRecord::Base  
  belongs_to  :order
  has_attachment :storage => :file_system,
                 :max_size => 2.megabytes,
                 :path_prefix => 'public/system/uploads'
  validates_as_attachment
  
  after_destroy :save_dispatches
  
  def save_dispatches
    if order
      order.dispatches.each { |dispatch| dispatch.save(false) }
    end
  end
end