class AddTariffCodeToStyle < ActiveRecord::Migration
  def self.up
    change_table(:styles) do |t|
      t.string    :tariff_code
    end
  end

  def self.down
    change_table(:styles) do |t|
      t.remove      :tariff_code
    end
  end
end
