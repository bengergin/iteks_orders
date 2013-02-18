class PackSize < ActiveRecord::Base
  belongs_to :pack
  belongs_to :size
  has_many :dispatch_quantities, :dependent => :destroy
end
