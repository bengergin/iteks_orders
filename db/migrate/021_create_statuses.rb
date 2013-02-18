class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.text        :description
      t.date        :occurred_on
      t.belongs_to  :order
      t.belongs_to  :user
      t.string      :category
      t.string      :country_of_manufacture
      t.belongs_to  :factory
      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
