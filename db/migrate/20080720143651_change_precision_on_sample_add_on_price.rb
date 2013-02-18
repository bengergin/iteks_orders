class ChangePrecisionOnSampleAddOnPrice < ActiveRecord::Migration
  def self.up
    change_table(:sample_add_ons) do |t|
      t.change(:price_gbp, :decimal, :precision => 8, :scale => 2)
      t.change(:price_eur, :decimal, :precision => 8, :scale => 2)
      t.change(:price_usd, :decimal, :precision => 8, :scale => 2)
    end
  end

  def self.down
    change_table(:sample_add_ons) do |t|
      t.change(:price_gbp, :decimal)
      t.change(:price_eur, :decimal)
      t.change(:price_usd, :decimal)
    end
  end
end
