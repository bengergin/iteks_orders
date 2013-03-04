class UploadedFile < ActiveRecord::Base
  has_many :attachments, :dependent => :destroy
  has_attachment :storage => :file_system,
                 :max_size => 2.megabytes,
                 :path_prefix => 'public/system/uploads',
                 :thumbnails => { :small => '315x315' },
                 :processor => 'Image_Science'
  validates_as_attachment
end