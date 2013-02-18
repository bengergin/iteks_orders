class ExchangeRate < ActiveRecord::Base
	acts_as_solr :fields => [:name]

  validates_presence_of :name

  NAMES = self.find(:all, :order => 'name').map { |c| c.name }
  validates_uniqueness_of :name
  
  has_and_belongs_to_many :despatches
  has_and_belongs_to_many :prices
  has_many :sample_statuses
  
  def self.[](name)
    find(:first, :conditions => { :name => name })
  end
end
