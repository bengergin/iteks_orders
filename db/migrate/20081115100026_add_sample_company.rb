class AddSampleCompany < ActiveRecord::Migration
  def self.up
    change_table(:samples) do |t|
      t.references :company
      t.index :company_id
    end
  end

  def self.down
    change_table(:samples) do |t|
      t.remove :company
      t.remove_index :company_id
    end
  end
end
