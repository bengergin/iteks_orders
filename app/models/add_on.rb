class AddOn < ActiveRecord::Base
  validates_presence_of :description
  has_many :pack_add_ons
end
