module SizeChartsHelper
  def measurement_prefix(measurement)
    "size_chart[#{new_or_existing(measurement)}_measurement_attributes][#{measurement.number}]"
  end
  
  def size_chart_diagram_prefix(size_chart_diagram)
    "size_chart[#{new_or_existing(size_chart_diagram)}_size_chart_diagram_attributes]"
  end
  
  def measurement_size_prefix(measurement, measurement_size)
    "size_chart[#{new_or_existing(measurement)}_measurement_attributes][#{measurement.number}][#{new_or_existing(measurement_size)}_measurement_size_attributes][]"
  end
end
