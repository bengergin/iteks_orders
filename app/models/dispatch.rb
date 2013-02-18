class Dispatch < ActiveRecord::Base  
  acts_as_solr :additional_fields => [:style_numbers, :barcode_numbers, :line_numbers]

  has_many :dispatch_quantities, :dependent => :destroy
  has_many :pack_sizes, :through => :dispatch_quantities
  has_many :quality_controls
  belongs_to :order
  belongs_to :transport
  belongs_to :country
  belongs_to :factory
  belongs_to :warehouse
  belongs_to :product
  belongs_to :department
  
  before_save  :write_foreign_fields, :calculate_lead_time_in_weeks
  after_update :save_dispatch_quantities
  after_save   :delete_dispatch
  
  validates_uniqueness_of :number, :scope => :order_id
  validates_presence_of   :customer_contract_date, :ex_factory_date
    
  with_options :order => "ex_factory_date, order_reference, number" do |d|
    d.named_scope :completed,  :conditions => "completed_on IS NOT NULL"
    d.named_scope :incomplete, :conditions => "completed_on IS NULL"
  end
  
  named_scope :placed_in, lambda { |country_id,unplaced|
    queries = []
    params  = []
    if unplaced
      queries << "factory_id IS NULL"
    end
    if !country_id.blank?
      queries << "country_id IN (?)"
      params << country_id
    end
    { :conditions => [queries.join(" OR "), *params] }
  }
  
  named_scope :is_complete, lambda { |complete| 
    if complete
      { :conditions => "completed_on IS NOT NULL" }
    else
      { :conditions => "completed_on IS NULL" }
    end
  }
  
  named_scope :is_product, lambda { |product_id|
    if product_id.blank?
      { }
    else
      { :conditions => { :product_id => product_id } }
    end
  }
  
  named_scope :for, lambda { |customer_id|
    if customer_id.blank?
      {}
    else
      { :conditions => { :customer_id => customer_id } }
    end
  }
  
  named_scope :for_department, lambda { |department_id|
    if department_id.blank?
      {}
    else
      { :conditions => { :department_id => department_id } }
    end
  }
  
  named_scope :by, lambda { |company_id|
   if company_id.blank?
     {}
    else
      { :conditions => { :company_id => company_id } }
    end  
  }
  
  named_scope :has, lambda { |buying_price| 
    if buying_price
      { :conditions => "buying_price IS NULL" }
    else
      {}
    end
  }
  
  def <=>(dispatch)
    number <=> dispatch.number
  end
  
  def style_numbers
    "#{order.style_number} #{pack_sizes.map { |p| p.style_number }.join(" ")}"
  end
  
  def barcode_numbers
    "#{order.barcode_number} #{pack_sizes.map { |p| p.barcode_number }.join(" ")}"
  end
  
  def line_numbers
    "#{order.line_number} #{pack_sizes.map { |p| p.line_number }.join(" ")}"
  end
  
  def reference
    number
  end
  
  def lead_time
    "%.1f weeks" % lead_time_in_weeks if lead_time_in_weeks?
  end
  
  def packs
    pack_sizes.map(&:pack).uniq
  end
  
  def delete_dispatch
    if self.dispatch_quantities.length.zero?
      self.delete
    end
  end
    
  def new_dispatch_quantity_attributes=(dispatch_quantity_attributes)
    dispatch_quantity_attributes.each do |attributes|
      dispatch_quantities.build(attributes) unless attributes[:quantity].blank?
    end
  end
  
  def existing_dispatch_quantity_attributes=(dispatch_quantity_attributes)
    dispatch_quantities.reject(&:new_record?).each do |dispatch_quantity|
      attributes = dispatch_quantity_attributes[dispatch_quantity.id.to_s]
      if attributes && !attributes[:quantity].blank?
        dispatch_quantity.attributes = attributes
      else
        dispatch_quantities.delete(dispatch_quantity)
      end
    end
  end
  
  def quantity_for_pack(letter)
    dispatch_quantities.sum(:quantity, :conditions => ["pack_letter = ?", letter])
  end
  
  def quantity_in_dozens
    quantity_in_pairs / 12
  end
  
  def save_dispatch_quantities
    dispatch_quantities.each do |dispatch_quantity|
      dispatch_quantity.save(false)
    end
  end
  
  def has_contract
    contract ? "Yes" : "No"
  end 
  
  protected
  
  def validate
    errors.add_to_base('There must be at least one quantity') if dispatch_quantities.length.zero?
  end
  
  private
  
  def write_foreign_fields
    private_methods.grep(/^write_(.+)_from_association/).each { |method| send(method) }
  end
  
  def write_order_reference_from_association
    self.order_reference = order.reference
  end
  
  def write_customer_reference_from_association
    self.customer_reference = order.customer.reference
  end
  
  def write_customer_id_from_association
    self.customer_id = order.customer_id
  end
  
  def write_customer_name_from_association
    self.customer_name = order.customer.name
  end
  
  def write_order_description_from_association
    self.order_description = order.full_description
  end
  
  def write_country_id_from_association
    self.country_id = order.try(:country_id)
  end
  
  def write_company_id_from_association
    self.company_id = order.try(:company_id)
  end
  
  def write_country_name_from_association
    self.country_name = order.country.try(:name)
  end
  
  def write_factory_id_from_association
    self.factory_id = order.factory_id
  end
  
  def write_factory_name_from_association
    self.factory_name = order.factory.try(:name)
  end
  
  def write_status_from_association
    self.status = order.statuses.try(:last).try(:description)
  end
  
  def write_has_add_ons_from_association
    self.has_add_ons = order.has_add_ons?
  end
  
  def write_contract_from_association
    if order.contracts.empty?
      self.contract = false
    else
      self.contract = true
    end
  end
  
  def write_qc_check_from_association
    unless order.quality_controls.empty?
      if order.quality_controls.last.pass_fail?
        self.qc_pass = true
      else
        self.qc_pass = false
      end
    end
  end
  
  def write_buying_price_from_association
    if order.packs.first.buying_price?
      self.buying_price = true
    else
      self.buying_price = nil
    end
  end
  
  def write_product_from_association
    self.product = order.style.try(:product)
  end
  
  def write_department_from_association
    self.department = order.try(:department)
  end
  
  # We have to use inject here because sum will try to calculate the total
  # quantity from the database but with a new dispatch there are no records
  # in the database yet but they are in memory.
  def write_quantity_in_packs_from_association
    self.quantity_in_packs = dispatch_quantities.inject(0) { |sum,dispatch_quantity| sum + (dispatch_quantity.quantity || 0) }
  end
  
  def write_quantity_in_pairs_from_association
    self.quantity_in_pairs = dispatch_quantities.inject(0) { |sum,dispatch_quantity| sum + (dispatch_quantity.quantity || 0) } * order.quantity_per_pack
  end
  
  def write_number_of_dispatch_quantities_from_association
    self.number_of_dispatch_quantities = dispatch_quantities.length
  end
  
  def write_number_of_packs_from_association
    self.total_number_of_packs = order.packs.count
  end
  
  def write_red_seal_approved_on_from_association
    red_seal_approved_on = nil
    packs_red_sealed = 0
    order.packs.each do |pack|
      if pack.red_seal_approved_on?
        red_seal_approved_on = pack.red_seal_approved_on 
        packs_red_sealed = packs_red_sealed + 1
      end
    end
    self.packs_red_sealed = packs_red_sealed
    self.red_seal_approved_on = red_seal_approved_on
  end
  
  def write_gold_seal_approved_on_from_association
   gold_seal_approved_on = nil
   packs_gold_sealed = 0
    order.packs.each do |pack|
      if pack.gold_seal_approved_on?
        gold_seal_approved_on = pack.gold_seal_approved_on 
        packs_gold_sealed = packs_gold_sealed + 1
      end
    end
    self.packs_gold_sealed = packs_gold_sealed
    self.gold_seal_approved_on = gold_seal_approved_on
  end
  
  def write_packaging_approved_on_from_association
    self.packaging_approved_on = order.packaging_approved_on
  end
  
  def write_testing_completed_on_from_association
    testing_completed_on = nil
    packs_tested = 0
    order.packs.each do |pack|
      if pack.testing_completed_on?  
        testing_completed_on = pack.testing_completed_on 
        packs_tested = packs_tested + 1
      end
    end
    self.packs_tested = packs_tested
    self.testing_completed_on = testing_completed_on
  end
  
  def write_pack_letters_from_association
    self.pack_letters = packs.map { |pack| pack.letter.upcase }.join(" ")
  end
  
  def calculate_lead_time_in_weeks
    self.lead_time_in_weeks = if order.placed_on && ex_factory_date
      ((ex_factory_date - order.placed_on).to_f / 7).abs
    end
  end
end
