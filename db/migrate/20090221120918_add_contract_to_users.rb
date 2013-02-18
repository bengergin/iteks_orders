class AddContractToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.boolean    :contract
    end
  end

  def self.down
    change_table(:users) do |t|
      t.remove      :contract
    end
  end
end
