class UploadedFile < ActiveRecord::Base
  has_many :attachments, :dependent => :destroy
  has_attachment :storage => :file_system,
                 :max_size => 2.megabytes,
                 :path_prefix => 'public/system/uploads',
                 :thumbnails => { :thumb => '315x315' }
  validates_as_attachment
end