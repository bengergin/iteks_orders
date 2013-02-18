class AddFormingToOrder < ActiveRecord::Migration
  def self.up
    change_table(:orders) do |t|
      t.integer       :forming
    end
  end

  def self.down
    change_table(:orders) do |t|
      t.remove       :forming
    end                    
  end
end
