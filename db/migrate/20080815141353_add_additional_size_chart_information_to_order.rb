class AddAdditionalSizeChartInformationToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :additional_size_chart_information, :text
  end

  def self.down
    remove_column :orders, :additional_size_chart_information
  end
end
