class SizeChartDiagram < ActiveRecord::Base
  has_many :size_charts
  has_attachment :content_type => :image, 
                 :storage => :file_system,
                 :path_prefix => 'public/system/size_chart_diagrams'
  validates_as_attachment
end
