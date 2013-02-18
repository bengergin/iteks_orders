class CreateCompaniesUsersJoin < ActiveRecord::Migration
  def self.up
    create_table :companies_users, :id => false do |t|
      t.belongs_to :company
      t.belongs_to :user
    end
  end

  def self.down
    drop_table :companies_users
  end
end