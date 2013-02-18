class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments, :force => true do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :departments
  end
end
