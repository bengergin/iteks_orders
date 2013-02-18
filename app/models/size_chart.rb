class SizeChart < ActiveRecord::Base
  INSIDE  = 0
  OUTSIDE = 1
  
  belongs_to :size_chart_diagram
  belongs_to :customer
  belongs_to :department
  has_many :orders
  has_many :measurements, :order => 'number'
  has_many :measurement_sizes, :through => :measurements
    
  after_update :save_measurements, :save_size_chart_diagram
  
  validates_presence_of :size_chart_diagram, :customer_id, :department_id, :description
  
  named_scope :specifications, :conditions =>  { :specification => true }
  named_scope :for, lambda { |customer_ids|
    if customer_ids.blank?
      {}
    else
      { :conditions => { :customer_id => customer_ids } }
    end
  }
  
  named_scope :for_department, lambda { |department_id|
    if department_id.blank?
      {}
    else
      { :conditions => { :department_id => department_id } }
    end
  }
  
  def sizes
    measurements(false).map(&:measurement_sizes).flatten.map(&:size).uniq
  end
  
  def reference
 if  created_at < Date.parse("2012-08-01 00:00:00.000000 ")
    "SC-%0.3i" % id unless new_record?
 else 
  "13-%0.3i" % id unless new_record?
 end
  end
  
  def reference_with_description
    "#{reference} #{description}"
  end
  
  def measuring_style
    (inside_outside == OUTSIDE) ? "Outside" : "Inside"
  end
  
  def new_measurement_attributes=(measurement_attributes)
    measurement_attributes.each do |number, attributes|
      measurements.build(attributes.merge(:number => number).reverse_merge("existing_measurement_size_attributes" => {})) unless attributes.values_blank?
    end
  end
  
  def existing_measurement_attributes=(measurement_attributes)
    measurements.reject(&:new_record?).each do |measurement|
      attributes = measurement_attributes[measurement.number.to_s]
      if attributes && !attributes[:name].blank?
        measurement.attributes = attributes.reverse_merge("existing_measurement_size_attributes" => {})
      else
        measurements.delete(measurement)
      end
    end
  end
  
  def save_measurements
    measurements.each do |measurement|
      measurement.save(false)
    end
  end
  
  def new_size_chart_diagram_attributes=(size_chart_diagram_attributes)
    build_size_chart_diagram(size_chart_diagram_attributes)
  end
  
  def existing_size_chart_diagram_attributes=(size_chart_diagram_attributes)
    size_chart_diagram && (size_chart_diagram.uploaded_data = size_chart_diagram_attributes[:uploaded_data])
  end
  
  def save_size_chart_diagram
    size_chart_diagram && size_chart_diagram.save
  end
  
  def clone
    clone = super
    clone.measurements = measurements.map(&:clone)
    clone.size_chart_diagram_id = size_chart_diagram_id
    clone
  end
end
