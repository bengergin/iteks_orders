class AddApprovalAndCompletionDatesToPacks < ActiveRecord::Migration
  def self.up
    change_table(:packs) do |t|
      t.date    :red_seal_approved_on,
                :gold_seal_approved_on,
                :fibre_composition_received_on,
                :testing_completed_on
      
      t.string  :currency
      t.decimal :buying_price,
                :exchange_rate,
                :precision => 8,
                :scale => 3
                
      t.index   :red_seal_approved_on
      t.index   :gold_seal_approved_on
      t.index   :testing_completed_on
      t.index   :fibre_composition_received_on
    end
  end

  def self.down
    change_table(:packs) do |t|
      t.remove_index :red_seal_approved_on
      t.remove_index :gold_seal_approved_on
      t.remove_index :testing_completed_on
      t.remove_index :fibre_composition_received_on
      
      t.remove :red_seal_approved_on,
               :testing_completed_on,
               :gold_seal_approved_on,
               :fibre_composition_received_on,
               :currency,
               :buying_price,
               :exchange_rate
    end
  end
end
