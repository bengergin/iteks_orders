class AddProuctToStyles < ActiveRecord::Migration
  def self.up
    change_table(:styles) do |t|
      t.references  :product
    end
  end

  def self.down
    change_table(:styles) do |t|
      t.remove      :product
    end
  end
end
