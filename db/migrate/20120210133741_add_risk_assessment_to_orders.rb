class AddRiskAssessmentToOrders < ActiveRecord::Migration
  def self.up
  	change_table(:orders) do |t|
    	t.text   :risk_assessment
    end
  end

  def self.down
  	change_table(:orders) do |t|
    	t.remove    :risk_assessment
    
  end
end
end
