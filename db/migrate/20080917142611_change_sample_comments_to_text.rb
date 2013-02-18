class ChangeSampleCommentsToText < ActiveRecord::Migration
  def self.up
    change_table(:samples) do |t|
      t.change(:comments, :text)
    end
  end

  def self.down
    change_table(:samples) do |t|
      t.change(:comments, :string)
    end
  end
end
