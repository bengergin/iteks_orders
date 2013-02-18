class AddEmailSentToQc < ActiveRecord::Migration
  def self.up
    	change_table(:quality_controls) do |t|
      	t.boolean     :email_sent 
    	end
    	QualityControl.update_all( "email_sent = 1" )
  	end

  	def self.down
    	change_table(:quality_controls) do |t|
      	t.remove     :email_sent
  	end
	end
end
