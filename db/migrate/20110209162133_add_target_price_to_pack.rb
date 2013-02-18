class AddTargetPriceToPack < ActiveRecord::Migration
  def self.up
    change_table(:packs) do |t|
      t.float       :target_price
    end
  end

  def self.down
    change_table(:packs) do |t|
      t.remove      :target_price
    end                    
  end
end
