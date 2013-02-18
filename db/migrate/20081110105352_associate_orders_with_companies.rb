class AssociateOrdersWithCompanies < ActiveRecord::Migration

  def self.up
    @akcorap = Company.find_by_name("AK Corap")
    @prem = Company.find_by_name("Prem Tekstil")
    Order.all.each do |order|
      case order.customer.reference
      when "FCMNX"
        order.company = @prem
      when /FAPKXM|FCETS/
        order.company = @akcorap
      else
        order.company = Company.find_by_name("Fimex Ltd")
      end
      order.save
    end
  end

  def self.down
  end
end
