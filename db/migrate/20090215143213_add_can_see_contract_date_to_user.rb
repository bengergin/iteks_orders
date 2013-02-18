class AddCanSeeContractDateToUser < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.boolean    :contract_date
    end
  end

  def self.down
    change_table(:users) do |t|
      t.remove      :contract_date
    end
  end
end
