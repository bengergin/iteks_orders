class AddDdpToOrder < ActiveRecord::Migration
  def self.up
    change_table(:orders) do |t|
      t.boolean       :ddp
    end
  end

  def self.down
    change_table(:orders) do |t|
      t.remove       :ddp 
    end                    
  end
end