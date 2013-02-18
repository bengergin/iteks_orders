class AddMetalDetectToQcReports < ActiveRecord::Migration
  def self.up
    	change_table(:quality_controls) do |t|
      	t.boolean     :metal_detect
    	end
  	end

  	def self.down
    	change_table(:quality_controls) do |t|
      	t.remove     :metal_detect
  	end
	end
end
