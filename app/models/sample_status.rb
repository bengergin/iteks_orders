class SampleStatus < ActiveRecord::Base
  belongs_to :sample
  belongs_to :exchange_rate
  belongs_to :creator, :class_name => "User", :foreign_key => "created_by"
  belongs_to :updater, :class_name => "User", :foreign_key => "updated_by"
  
end
