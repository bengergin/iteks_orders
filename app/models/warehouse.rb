class Warehouse < ActiveRecord::Base
  belongs_to :country
  belongs_to :customer
  
  validates_presence_of :name, :customer_id
end
