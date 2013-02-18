class CorrectSizeChartDiagramRelationship < ActiveRecord::Migration
  def self.up
    remove_column :size_chart_diagrams, :size_chart_id
    add_column :size_charts, :size_chart_diagram_id, :integer
  end

  def self.down
    add_column :size_chart_diagrams, :size_chart_id, :integer
    remove_column :size_charts, :size_chart_diagram_id
  end
end
