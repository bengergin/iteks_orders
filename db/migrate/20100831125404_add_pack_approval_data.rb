class AddPackApprovalData < ActiveRecord::Migration
  def self.up
    change_table(:dispatches) do |t|
      t.integer     :packs_red_sealed, :default => 0
      t.integer     :packs_gold_sealed, :default => 0
      t.integer     :packs_tested, :default => 0
      t.integer     :total_number_of_packs, :default => 0 
    end
  end

  def self.down
    change_table(:dispatches) do |t|
      t.remove      :packs_red_sealed
      t.remove      :packs_gold_sealed
      t.remove      :packs_tested
      t.remove      :total_number_of_packs
    end                    
  end                      
end                        
