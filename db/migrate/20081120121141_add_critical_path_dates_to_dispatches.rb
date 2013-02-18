class AddCriticalPathDatesToDispatches < ActiveRecord::Migration
  def self.up
    change_table(:dispatches) do |t|
      t.date  :bulk_yarn_ordered_on,
              :bulk_yarn_ordered_by,
              :bulk_yarn_arrived_on,
              :bulk_yarn_arrived_by,
              :knitting_started_on,
              :knitting_started_by
      
      t.index :bulk_yarn_arrived_on
      t.index :bulk_yarn_arrived_by
      t.index :knitting_started_on
      t.index :knitting_started_by
    end
  end

  def self.down
    change_table(:dispatches) do |t|
      t.remove :bulk_yarn_ordered_on,
               :bulk_yarn_ordered_by,
               :bulk_yarn_arrived_on,
               :bulk_yarn_arrived_by,
               :knitting_started_on,
               :knitting_started_by
      
      t.remove_index :bulk_yarn_arrived_on
      t.remove_index :bulk_yarn_arrived_by
      t.remove_index :knitting_started_on
      t.remove_index :knitting_started_by
    end
  end
end