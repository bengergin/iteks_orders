class CreatePacks < ActiveRecord::Migration
  def self.up
    create_table :packs, :force => true do |t|
      t.string      :description
      t.string      :design_reference
      t.string      :sample_reference
      t.text        :sample_comments
      t.string      :fibre_composition
      t.float       :buying_price_gbp
      t.float       :buying_price_eur
      t.float       :buying_price_usd
      t.float       :gross_price_gbp
      t.float       :gross_price_eur
      t.float       :gross_price_usd

      t.string      :letter, :limit => 1, :default => 'A', :null => false
      t.belongs_to  :order
      t.timestamps
    end
  end

  def self.down
    drop_table :packs
  end
end
