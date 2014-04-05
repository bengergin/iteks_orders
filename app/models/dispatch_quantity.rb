class DispatchQuantity < ActiveRecord::Base  
  belongs_to :dispatch
  belongs_to :pack_size
  belongs_to :country
  belongs_to :factory
  belongs_to :order

  
  validates_numericality_of :quantity
  
  before_save   :write_foreign_fields
  after_update    :delete_dispatch_quantity
  
  named_scope :incomplete, :conditions => 'completed_on IS NULL',
              :order => 'ex_factory_date, order_reference, dispatch_number, pack_letter, size_subscript'
  named_scope :completed, :conditions => 'completed_on IS NOT NULL',
              :order => 'ex_factory_date, order_reference, dispatch_number, pack_letter, size_subscript'
  named_scope :for_merch, lambda { |merch| { :conditions => ["customer_id IN (?)", merch.customer_ids], :order => 'ex_factory_date, order_reference, dispatch_number, pack_letter, size_subscript' } }
  
  def <=>(dispatch_quantity)
    letter = pack_size.pack.letter <=> dispatch_quantity.pack_size.pack.letter
    if letter == 0
      pack_size.size.subscript <=> dispatch_quantity.pack_size.size.subscript
    else
      letter
    end
  end
  
  def lead_time
    "%.1f weeks" % lead_time_in_weeks if lead_time_in_weeks?
  end
  
  def quantity_in_dozens
    quantity_in_pairs / 12
  end
  
  def estimated_transport_cost
  	pack_size.pack.estimated_transport_cost * quantity unless !pack_size.pack.estimated_transport_cost
  end
  
  def buying_cost_gbp
    pack_size.pack.buying_price_per_pack_in_gbp * quantity unless !pack_size.pack.buying_price_per_pack_in_gbp
  end
  
  def net_selling_cost_gbp
		pack_size.pack.selling_cost_gbp * quantity unless !pack_size.pack.selling_cost_gbp
  end 
  
  def estimated_profit
  	if pack_size.pack.selling_cost_gbp && pack_size.pack.buying_price_per_pack_in_gbp && pack_size.pack.estimated_transport_cost
  		((pack_size.pack.selling_cost_gbp - pack_size.pack.buying_price_per_pack_in_gbp - pack_size.pack.estimated_transport_cost) * quantity)
  	else
  		0
  	end
  end
  
  private
  
  def delete_dispatch_quantity
    if self.quantity == 0
      self.destroy
    end
  end
  
  def write_foreign_fields
    private_methods.grep(/^write_(.+)_from_association/).each { |method| send(method) }
  end
  
  def write_completed_on_from_association
    self.completed_on = dispatch.completed_on
  end
  
  def write_ex_factory_date_from_association
    self.ex_factory_date = dispatch.ex_factory_date
  end
  
  def write_customer_contract_date_from_association
    self.customer_contract_date = dispatch.customer_contract_date
  end
  
  def write_dispatch_number_from_association
    self.dispatch_number = dispatch.number
  end
  
  def write_warehouse_name_from_association
    self.warehouse_name = dispatch.warehouse
  end
  
  def write_pack_letter_from_association
    self.pack_letter = pack_size.pack.letter
  end
  
  def write_size_name_from_association
    self.size_name = pack_size.size.name
  end
  
  def write_pack_description_from_association
    self.pack_description = pack_size.pack.description
  end
  
  def write_order_reference_from_association
    self.order_reference = dispatch.order_reference
  end
  
  def write_order_id_from_association
    self.order_id = dispatch.order_id
  end
  
  def write_customer_reference_from_association
    self.customer_reference = dispatch.customer_reference
  end
  
  def write_customer_id_from_association
    self.customer_id = dispatch.try(:customer_id)
  end
  
  def write_customer_name_from_association
    self.customer_name = dispatch.customer_name
  end
  
  def write_order_description_from_association
    self.order_description = dispatch.order_description
  end
  
  def write_country_id_from_association
    self.country_id = dispatch.try(:country_id)
  end
  
  def write_company_id_from_association
    self.company_id = dispatch.try(:company_id)
  end
  
  def write_country_name_from_association
    self.country_name = dispatch.country_name
  end
  
  def write_factory_name_from_association
    self.factory_name = dispatch.factory_name
  end
  
  def write_status_from_association
    self.status = dispatch.status
  end
  
  def write_has_add_ons_from_association
    self.has_add_ons = dispatch.has_add_ons?
  end
  
  def write_lead_time_in_weeks_from_association
    self.lead_time_in_weeks = dispatch.lead_time_in_weeks
  end
  
  def write_number_of_dispatch_quantities_from_association
    self.number_of_dispatch_quantities = dispatch.number_of_dispatch_quantities
  end
  
  def write_quantity_in_pairs_from_association
    self.quantity_in_pairs = (quantity || 0) * dispatch.order.quantity_per_pack
  end
  
  def write_red_seal_approved_on_from_association
    self.red_seal_approved_on = dispatch.red_seal_approved_on
  end
  
  def write_gold_seal_approved_on_from_association
    self.gold_seal_approved_on = dispatch.gold_seal_approved_on
  end
  
  def write_packaging_approved_on_from_association
    self.packaging_approved_on = dispatch.packaging_approved_on
  end
  
  def write_testing_completed_on_from_association
    self.testing_completed_on = dispatch.testing_completed_on
  end
  
  def write_size_subscript_from_association
    self.size_subscript = pack_size.size.subscript
  end
end
