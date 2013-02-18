class AddProductToDispatch < ActiveRecord::Migration
  def self.up
    change_table(:dispatches) do |t|
      t.references    :product
    end
  end

  def self.down
    change_table(:dispatches) do |t|
      t.remove      :product
    end
  end
end
