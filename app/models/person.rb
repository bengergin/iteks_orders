class Person < ActiveRecord::Base
  include Nameable
  
  validates_presence_of :first_name
  has_many :roles
  has_many :factories, :through => :roles
  has_many :customers, :through => :roles
  belongs_to :country
end
