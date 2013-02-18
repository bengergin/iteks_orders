class Country < ActiveRecord::Base
	acts_as_solr :fields => [:name]
	
  NAMES = self.find(:all, :order => 'name').map { |c| c.name }
  validates_uniqueness_of :name
  
  has_and_belongs_to_many :users

  has_many :factories
  
  def self.[](name)
    find(:first, :conditions => { :name => name })
  end
end
