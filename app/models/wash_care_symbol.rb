class WashCareSymbol < ActiveRecord::Base
  has_and_belongs_to_many :orders
  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :path_prefix => 'public/system/wash_care_symbols'
  validates_as_attachment
end
