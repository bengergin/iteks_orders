class UsersDepartmentsJoin < ActiveRecord::Migration
  def self.up
    create_table(:departments_users, :id => false) do |t|
      t.references :department, :user
    end
    add_index :departments_users, :user_id
    add_index :departments_users, [ :department_id, :user_id ], :unique => true
  end

  def self.down
    drop_table(:departments_users)
  end
end
