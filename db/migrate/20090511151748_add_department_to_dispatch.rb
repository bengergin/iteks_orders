class AddDepartmentToDispatch < ActiveRecord::Migration
  def self.up
    change_table(:dispatches) do |t|
      t.references    :department
    end
  end

  def self.down
    change_table(:dispatches) do |t|
      t.remove_references :department
    end
  end
end