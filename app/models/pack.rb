class Pack < ActiveRecord::Base

  belongs_to :order
  belongs_to :design
  has_many :pack_sizes, :dependent => :destroy
  has_many :pack_add_ons, :dependent => :destroy
  has_many :add_ons, :through => :pack_add_ons
  has_many :dispatch_quantities, :through => :pack_sizes
  
  validates_associated :pack_sizes, :pack_add_ons
  validates_presence_of :description
  
  before_save :save_exchange_rate
  after_save :take_design
  after_update :save_pack_add_ons, :save_pack_sizes
  
  def reference
    letter.upcase
  end
  
  def new_design_reference
    design.reference if design
  end 
  
  def net_price_gbp
    (100 - order.customer.settlement_discount) * (gross_price_gbp / 100) if gross_price_gbp?
  end
  
  def net_price_eur
    (100 - order.customer.settlement_discount) * (gross_price_eur / 100) if gross_price_eur?
  end
  
  def net_price_usd
    (100 - order.customer.settlement_discount) * (gross_price_usd / 100) if gross_price_usd?
  end
  
  def new_design_reference=(reference)
    self.design = unless reference.blank?
      Design.find_by_reference(reference)
    end
  end
  
  def <=>(pack)
    letter <=> pack.letter
  end
  
  def take_design
    design.try(:take!)
  end
  
  def save_exchange_rate
    unless saved_exchange_rate
      if gross_price_gbp
        self.saved_exchange_rate = ExchangeRate.find_by_name("STERLING").rate
      elsif gross_price_eur
        self.saved_exchange_rate = ExchangeRate.find_by_name("EURO").rate
      elsif gross_price_usd
        self.saved_exchange_rate = ExchangeRate.find_by_name("US DOLLAR").rate
      end
    end
  end
  
  def self.new_with_add_on(attributes=nil, &block)
    pack = new(attributes, &block)
    pack.pack_add_ons.build
    pack.pack_add_ons.each {|pack_add_on| pack_add_on.build_add_on }
    pack
  end
  
  def existing_pack_add_on_attributes=(pack_add_on_attributes)
    pack_add_ons.reject(&:new_record?).each do |pack_add_on|
      attributes = pack_add_on_attributes[pack_add_on.id.to_s]
      if !attributes[:quantity].blank?
        pack_add_on.quantity = attributes[:quantity]
        pack_add_on.add_on = AddOn.find_or_initialize_by_description_and_reference(attributes[:description], attributes[:reference])
      else
        pack_add_ons.delete(pack_add_on)
      end
    end
  end
  
  def save_pack_add_ons
    pack_add_ons.each do |pack_add_on|
      pack_add_on.save(false)
    end
  end
  
  def existing_pack_size_attributes=(pack_size_attributes) 
    pack_sizes.reject(&:new_record?).each do |pack_size| 
      attributes = pack_size_attributes[pack_size.id.to_s] 
      if attributes
        pack_size.attributes = attributes 
      else 
        pack_sizes.delete(pack_size) 
      end 
    end 
  end 
  
  def save_pack_sizes
    pack_sizes.each do |pack_size|
      pack_size.save(false)
    end
  end 
  
  def new_pack_add_on_attributes=(pack_add_on_attributes)
    pack_add_on_attributes.each do |attributes|
      unless attributes.values_blank?
        pack_add_ons.build(:quantity => attributes[:quantity]).add_on = AddOn.find_or_initialize_by_description_and_reference(attributes[:description], attributes[:reference])
      end
    end
  end
  
  def new_pack_size_attributes=(pack_size_attributes)
    pack_size_attributes.each do |attributes|
      pack_sizes.build(attributes)
    end
  end
  
  def total_quantity
    dispatch_quantities.sum(:quantity) || 0
  end
  
  def clone
    clone = super
    clone.pack_sizes = pack_sizes.map(&:clone)
    clone.pack_add_ons = pack_add_ons.map(&:clone)
    clone
  end
  
  def buying_price_per_pair_in_gbp
    if buying_price?
      
      price = buying_price.to_f / 12
      
      if currency == '£'
      	price
      elsif exchange_rate
        price / exchange_rate.to_f
      elsif currency == '$'
        price / ExchangeRate.find_by_name("US DOLLAR").rate
      elsif currency == '€'
        price / ExchangeRate.find_by_name("EURO").rate
      else
        price
      end
    end
  end
  
  def buying_price_per_pack_in_gbp
    if buying_price?
      buying_price_per_pair_in_gbp * order.quantity_per_pack
    end
  end
  
  def buying_price_per_dozen_in_gbp
    if currency == '£'
      buying_price
    elsif exchange_rate
      buying_price / exchange_rate
    elsif currency == '$'
      buying_price / ExchangeRate.find_by_name("US DOLLAR").rate
    elsif currency == '€'
      buying_price / ExchangeRate.find_by_name("EURO").rate
    else
      price
    end
  end
  
  def estimated_transport_cost
  	if buying_price?
    	if order.fob?
      	0.00
  		elsif order.ddp?
				if order.country.name == "Turkey"
					0.00
				else
    			(buying_price_per_pack_in_gbp * 0.14) 
    		end
    	elsif order.customer.country.name == "Australia"
    		if buying_price_per_pack_in_gbp
					(buying_price_per_pack_in_gbp * 0.20) 
				else
					0.00
				end
    	elsif order.country.name == "Turkey"
    		((0.36 / 12) * order.quantity_per_pack)
    	elsif buying_price?
    		(buying_price_per_pack_in_gbp * 0.24) 
    	else
      	0.00
			end
    else
    	0.00
    end
  end
  
  def estimated_profit
    if buying_price?
      if gross_price_gbp? && net_price_gbp && buying_price_per_pack_in_gbp
        ((net_price_gbp - buying_price_per_pack_in_gbp - estimated_transport_cost) / (buying_price_per_pack_in_gbp + estimated_transport_cost)) * 100
      elsif gross_price_eur? && net_price_eur && buying_price_per_pack_in_gbp && saved_exchange_rate?
        (((net_price_eur / saved_exchange_rate) - buying_price_per_pack_in_gbp - estimated_transport_cost) / (buying_price_per_pack_in_gbp + estimated_transport_cost)) * 100
      elsif gross_price_usd? && net_price_usd && buying_price_per_pack_in_gbp && saved_exchange_rate?
        (((net_price_usd / saved_exchange_rate) - buying_price_per_pack_in_gbp - estimated_transport_cost) / (buying_price_per_pack_in_gbp + estimated_transport_cost)) * 100
      end
    end
  end
  
  def buying_and_transport_cost_gbp
    if buying_price?
      if gross_price_gbp? && net_price_gbp && buying_price_per_pack_in_gbp
        buying_price_per_pack_in_gbp + estimated_transport_cost
      end
    end
  end
  
  def selling_cost_gbp
    if gross_price_gbp? && net_price_gbp
      net_price_gbp
    elsif gross_price_eur? && net_price_eur && saved_exchange_rate?
      net_price_eur / saved_exchange_rate
    elsif gross_price_usd? && net_price_usd && saved_exchange_rate?
      net_price_usd / saved_exchange_rate
    end
  end
  
  def profit_gbp
  	if buying_and_transport_cost_gbp && selling_cost_gbp
  		((selling_cost_gbp - buying_and_transport_cost_gbp) * total_quantity)
  	else
  		0.00
  	end
  end
  
  protected
  def validate
    errors.add_to_base('There must be at least one size selected for each pack') if pack_sizes.length.zero?
  end
end
