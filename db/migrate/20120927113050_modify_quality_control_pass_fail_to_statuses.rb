class ModifyQualityControlPassFailToStatuses < ActiveRecord::Migration
  def self.up
      change_table(:orders) do |t|
    t.change(:qc, :text, :limit => nil)
      end
  end

  def self.down
    change_table(:orders) do |t|
  t.change(:qc, :text, :limit => nil)
    end 
  end
end