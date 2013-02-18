class AddSellingInfoToPacks < ActiveRecord::Migration
  def self.up
    change_table(:packs) do |t|
      t.string       :selling_info
    end
  end

  def self.down
    change_table(:packs) do |t|
      t.remove       :selling_info   
    end                    
  end
end