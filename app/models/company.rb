class Company < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :orders
  has_many :samples
  
  validates_uniqueness_of :name
end