class ResetExistingSentDatesFromSamples < ActiveRecord::Migration
  def self.up
    Sample.all.each do |sample|
      sample.update_attribute(:sent_on, nil)
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
