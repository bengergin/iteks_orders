class Size < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :subscript, :only_integer => true
  has_many :pack_sizes
  belongs_to :department
end
