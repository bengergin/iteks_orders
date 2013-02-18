class ReplaceCustomerReferencesWithCodes < ActiveRecord::Migration
  def self.up
    Customer.all.each do |customer|
      customer.reference = customer.code
      customer.save
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
