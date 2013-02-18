class BoxEndLabelPosition < ActiveRecord::Base
  has_many :orders
  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :path_prefix => 'public/system/box_end_label_positions'
  validates_as_attachment
end
