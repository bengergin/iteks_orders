class AddContractToDispatches < ActiveRecord::Migration  
  def self.up
    change_table(:dispatches) do |t|
      t.boolean    :contract
    end
  end

  def self.down
    change_table(:dispatches) do |t|
      t.remove      :contract
    end
  end
end
