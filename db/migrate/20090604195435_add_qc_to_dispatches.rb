class AddQcToDispatches < ActiveRecord::Migration
  def self.up
    change_table(:dispatches) do |t|
      t.boolean    :qc_pass
    end
  end

  def self.down
    change_table(:dispatches) do |t|
      t.remove      :qc_pass
    end
  end
end
