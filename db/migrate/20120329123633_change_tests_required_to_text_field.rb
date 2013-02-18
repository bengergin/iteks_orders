class ChangeTestsRequiredToTextField < ActiveRecord::Migration
  def self.up
      change_table(:orders) do |t|
    t.change(:required_tests, :text, :limit => nil)
      end
  end

  def self.down
    change_table(:orders) do |t|
  t.change(:required_tests, :text, :limit => nil)
    end 
  end
end
