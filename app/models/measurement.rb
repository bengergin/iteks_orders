class Measurement < ActiveRecord::Base
  belongs_to :size_chart
  has_many :measurement_sizes, :dependent => :destroy
  
  validates_presence_of :name
  
  after_update :save_measurement_sizes
  
  def new_measurement_size_attributes=(measurement_size_attributes)
    measurement_size_attributes.each do |attributes|
      measurement_sizes.build(attributes) unless attributes.values_blank?
    end
  end
  
  def existing_measurement_size_attributes=(measurement_size_attributes) 
    measurement_sizes.reject(&:new_record?).each do |measurement_size| 
      attributes = measurement_size_attributes[measurement_size.id.to_s] 
      if attributes && !attributes[:value].blank?
        measurement_size.attributes = attributes 
      else 
        measurement_sizes.delete(measurement_size) 
      end 
    end 
  end 
  
  def save_measurement_sizes
    measurement_sizes.each do |measurement_size|
      measurement_size.save(false)
    end
  end 
  
  def clone
    clone = super
    clone.measurement_sizes = measurement_sizes.map(&:clone)
    clone
  end
end