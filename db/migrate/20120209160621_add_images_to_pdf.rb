class AddImagesToPdf < ActiveRecord::Migration
  def self.up
    	change_table(:uploaded_files) do |t|
      	t.boolean     :add_to_pdf
    	end
  	end

  	def self.down
    	change_table(:uploaded_files) do |t|
      	t.remove     :add_to_pdf
  	end
	end
end
