class Order < ActiveRecord::Base
  PIECE_DYED = 0
  YARN_DYED  = 1
  
  DYING_METHOD = {
    PIECE_DYED => "Piece",
    YARN_DYED  => "Yarn"
  }
  
  CYLINDER_TYPE = {
    1 => "Single",
    2 => "Double"
  }
  
  SPATULA = 1
  PROFILE = 2
    
  has_and_belongs_to_many :wash_care_symbols, :order => 'filename'
  has_and_belongs_to_many :testings
  belongs_to :customer
  belongs_to :country
  belongs_to :factory
  belongs_to :department
  belongs_to :style
  belongs_to :size_chart
  belongs_to :box_end_label_position
  belongs_to :user
  belongs_to :weight_size, :class_name => "Size"
  belongs_to :packaging
  belongs_to :country
  belongs_to :company
  has_many :packs, :dependent => :destroy, :order => 'letter'
  has_many :pack_sizes, :through => :packs, :uniq => true
  has_many :dispatches, :dependent => :destroy, :order => 'ex_factory_date, number'
  has_many :dispatch_quantities, :through => :dispatches, :uniq => true
  has_many :statuses
  has_many :attachments, :as => :attachable, :dependent => :destroy
  has_many :uploaded_files, :through => :attachments, :dependent => :destroy
  has_many :contracts, :dependent => :destroy
  has_many :designs, :through => :packs
  has_many :quality_controls
  
  validates_presence_of :customer_id, :department_id, :season, :description, :quantity_per_pack
  validates_numericality_of :quantity_per_pack
  
  named_scope :completed, :conditions => "completed_on IS NOT NULL"
  named_scope :incomplete, :conditions => "completed_on IS NULL"
  named_scope :packaging_approved, :conditions => "packaging_approved_on IS NOT NULL"
  named_scope :testing_completed, :conditions => "testing_completed_on IS NOT NULL"
  named_scope :testing_incomplete, :conditions => "testing_completed_on IS NULL"
  named_scope :placed, :conditions => "placed_on IS NOT NULL"
  named_scope :unplaced, :conditions => "placed_on IS NULL"
  named_scope :qc, :conditions => "qc IS NOT NULL"
  
  after_save :save_packs, :save_dispatches
  
  def new_packaging_reference
    packaging.reference if packaging
  end 
  
  def new_packaging_reference=(reference)
    self.packaging = unless reference.blank?
      Packaging.find_by_reference(reference)
    end
  end
  
  # Custom new to create a pack and some add_ons.
  def self.new_with_packs(attributes=nil, &block)
    order = new(attributes, &block)
    if order.packs.length.zero?
      order.packs.build(:letter => 'a') unless order.packs.map(&:letter).include?('a')
      
      # Pack Add Ons
      order.packs.each do |pack|
        pack.pack_add_ons.build if pack.pack_add_ons.length.zero?
        pack.pack_add_ons.each {|pack_add_ons| pack_add_ons.build_add_on unless pack_add_ons.add_on }
      end
    end
    
    order
  end
  
  # Custom getters to return more useful information about certain attributes.
  def full_description
    "#{quantity_per_pack}pk #{department.name} #{style.name} #{description}"
  end
  
  def how_dyed
    DYING_METHOD[dyed]
  end

  def cylinder_type
    CYLINDER_TYPE[number_of_cylinders]
  end
  
  def sock_forming
    case forming
    when SPATULA then "Spatula"
    when PROFILE then "Profile"
    end
  end
  
  def sock_weight
    if weight
      sock_weight = "#{weight} grammes per pair"
      if weight_size
        sock_weight << " of #{weight_size.name}"
      end
    end
  end

  def reference
    "ITO-%0.3i/#{customer.reference}" % id unless new_record?
  end
  
  def total_quantity_in_pairs
    total_quantity_in_packs * quantity_per_pack
  end
  
  def total_quantity_in_packs
    dispatches.sum(:quantity_in_packs)
  end 
  
  def has_add_ons?
    PackAddOn.exists?(:pack_id => pack_ids)
  end
  
  def washed
    goods_need_washing ? "Yes" : "No"
  end
  
  def metal_detect
    metal_detected ? "Yes" : "No"
  end
  
  # Methods for saving and updating.
  def new_pack_attributes=(pack_attributes)
    pack_attributes.each do |letter, attributes|
      packs.build(attributes.merge(:letter => letter.to_s)) unless attributes.values_blank?
    end
  end
  
  def existing_pack_attributes=(pack_attributes)
    packs.reject { |p| p.new_record? }.each do |pack|
      attributes = pack_attributes[pack.letter]
      if attributes && !attributes.values_blank?
        pack.attributes = attributes.reverse_merge("existing_pack_size_attributes" => {})
      else
        packs.delete(pack)
      end
    end
  end
  
  def save_packs
    packs.each do |pack|
      pack.save(false)
    end
  end
  
  def uploaded_files=(attributes)
    for uploaded_file in attributes
      attachments.create(:uploaded_file => UploadedFile.create(uploaded_file))
    end
  end
  
  def contracts=(attributes)
    for contract in attributes
      Contract.create(contract)
    end  
  end
  
  def total_profit_gbp
  	profit = 0
  	packs.each do |p|
  		profit = p.profit_gbp + profit
  	end
  	profit
  end
  
  # Dispatches
  def new_dispatch_attributes=(dispatch_attributes)
    dispatch_attributes.each do |number, attributes|
      dispatches.build(attributes.merge(:number => number.to_s)) unless attributes.values_blank?
    end
  end
  
  def existing_dispatch_attributes=(dispatch_attributes)
    dispatches.reject(&:new_record?).each do |dispatch|
      attributes = dispatch_attributes[dispatch.number.to_s]
      if attributes && !attributes.values_blank?
        dispatch.attributes = attributes
      else
        dispatches.delete(dispatch)
      end
    end
  end
  
  def attachment_attributes=(attachment_attributes)
    attachment_attributes.each do |attachment|
      attachments.build(attachment)
    end
  end
  
  def save_dispatches
    dispatches.each { |dispatch| dispatch.save(false) }
  end
  
  def clone
    clone = super
    clone
  end
  
  protected
  
  def validate
    errors.add_to_base('There must be at least one pack') if packs.length.zero?
  end
end
