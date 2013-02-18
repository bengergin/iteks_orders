class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.references :person
      t.references :company, :polymorphic => true
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
