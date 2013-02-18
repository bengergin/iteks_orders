class AddQualityControlPassFailToStatuses < ActiveRecord::Migration
  def self.up
    change_table(:statuses) do |t|
      t.boolean       :qc
    end
  end

  def self.down
    change_table(:statuses) do |t|
      t.remove       :qc
    end                    
  end
end