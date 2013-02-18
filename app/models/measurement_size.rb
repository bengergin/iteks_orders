class MeasurementSize < ActiveRecord::Base
  belongs_to :measurement
  belongs_to :size
end