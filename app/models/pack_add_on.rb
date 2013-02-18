class PackAddOn < ActiveRecord::Base
  belongs_to :add_on
  belongs_to :pack
  delegate :description, :to => :add_on
  delegate :reference, :to => :add_on
  validates_numericality_of :quantity
  validates_presence_of :quantity
  
  validates_associated :add_on
end
