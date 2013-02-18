class AddDetailsToFactories < ActiveRecord::Migration
  def self.up
    add_column :factories, :address, :text
    add_column :factories, :city, :string
    add_column :factories, :postcode, :string
    add_column :factories, :audited_by, :string
    add_column :factories, :comments, :text
    add_column :factories, :current_customers, :string
    add_column :factories, :machine_breakdown, :text
    add_column :factories, :metal_detection, :boolean
    add_column :factories, :number_of_employees, :integer
    add_column :factories, :number_of_supervisors, :integer
    add_column :factories, :production_capacity_in_pairs, :string
    add_column :factories, :rating, :integer
    add_column :factories, :rating_comment, :text
    add_column :factories, :size, :string
    add_column :factories, :total_double_cylinder_machines, :integer
    add_column :factories, :total_flatbed_machines, :integer
    add_column :factories, :total_single_cylinder_machines, :integer
  end

  def self.down
    remove_column :factories, :address
    remove_column :factories, :city
    remove_column :factories, :postcode
    remove_column :factories, :audited_by
    remove_column :factories, :comments
    remove_column :factories, :current_customers
    remove_column :factories, :machine_breakdown
    remove_column :factories, :metal_detection
    remove_column :factories, :number_of_employees
    remove_column :factories, :number_of_supervisors
    remove_column :factories, :production_capacity_in_pairs
    remove_column :factories, :rating
    remove_column :factories, :rating_comment
    remove_column :factories, :size
    remove_column :factories, :total_double_cylinder_machines
    remove_column :factories, :total_flatbed_machines
    remove_column :factories, :total_single_cylinder_machines
  end
end
