class Metastatus
  
  attr_accessor :placed_on, 
                :unplaced,
                :red_seal_approved_on, 
                :gold_seal_approved_on,
                :testing_completed_on, 
                :bulk_yarn_ordered_on,
                :fibre_composition_received_on, 
                :packaging_proof_sent_on,
                :packaging_approved_on, 
                :bulk_yarn_arrived_on,
                :knitting_started_on,
                :completed_on,
                :order_id,
                :user_id,
                :factory_id,
                :buying_price,
                :currency,
                :exchange_rate,
                :uncomplete,
                :red_seal_rejected,
                :gold_seal_rejected,
                :testing_rejected,
                :description,
                :pinned,
                :quality_control,
                :qc,
               :quality_control_recieved,
                :target_price
                  
  def initialize(attributes={})
    self.attributes = attributes
  end
  
  def attributes=(attributes)
    attributes.each do |name, value|
      send("#{name}=", value) if respond_to?("#{name}=")
    end
  end
  
  def order
    @order ||= Order.find(order_id)
  end
  
  def dispatch_ids
    @dispatch_ids ||= []
  end
  
  def dispatch_ids=(dispatch_ids)
    @dispatch_ids = dispatch_ids
  end
  
  def pack_ids
    @pack_ids ||= []
  end
  
  def pack_ids=(pack_ids)
    @pack_ids = pack_ids
  end
  
  def packs
    pack_ids.map { |p| Pack.find(p) }
  end
  
  def user
    User.find(user_id)
  end 
  
  def dispatches
    dispatch_ids.map { |d| Dispatch.find(d) }
  end
  
  def save
    packs.each do |pack|
      pack.red_seal_approved_on = red_seal_approved_on unless red_seal_approved_on.blank?
      pack.red_seal_approved_on = "NIL" unless red_seal_rejected.blank?
      pack.gold_seal_approved_on = gold_seal_approved_on unless gold_seal_approved_on.blank?
      pack.gold_seal_approved_on = "NIL" unless gold_seal_rejected.blank?
      pack.testing_completed_on = testing_completed_on unless testing_completed_on.blank?
      pack.testing_completed_on = "NIL" unless testing_rejected.blank?
      pack.fibre_composition_received_on = fibre_composition_received_on unless fibre_composition_received_on.blank?
      if !placed_on.blank?
        pack.exchange_rate = exchange_rate unless exchange_rate.blank?
        pack.currency = currency unless currency.blank?
        pack.buying_price = buying_price unless buying_price.blank?
      end
      pack.target_price = target_price unless target_price.blank?
      order.statuses.create(:modifications => pack.changes, :description => description, :pinned => pinned, :user_id => user_id, :changed_type => "Pack", :changed_id => pack.id, :occurred_on => Time.new) unless pack.changes.values_blank?
      pack.save
    end
    dispatches.each do |dispatch|
      dispatch.gold_seal_approved_on = gold_seal_approved_on unless gold_seal_approved_on.blank?
      dispatch.completed_on = completed_on unless completed_on.blank?
      dispatch.completed_on = "NIL" unless uncomplete.blank?
      dispatch.knitting_started_on = knitting_started_on unless knitting_started_on.blank?
      dispatch.bulk_yarn_ordered_on = bulk_yarn_ordered_on unless bulk_yarn_ordered_on.blank?
      dispatch.bulk_yarn_arrived_on = bulk_yarn_arrived_on unless bulk_yarn_arrived_on.blank?
      order.statuses.create(:modifications => dispatch.changes, :description => description, :pinned => pinned, :user_id => user_id, :changed_type => "Dispatch", :changed_id => dispatch.id, :occurred_on => Time.new) unless dispatch.changes.values_blank?
      dispatch.save
    end
    if order
      order.packaging_proof_sent_on = packaging_proof_sent_on unless packaging_proof_sent_on.blank?
      order.packaging_approved_on = packaging_approved_on unless packaging_approved_on.blank?
 			
     
      if !placed_on.blank? && factory_id
        order.placed_on = placed_on unless placed_on.blank?
        order.factory_id = factory_id 
        StatusMailer.deliver_factory(order, factory_id, user_id, description)
        StatusMailer.deliver_profit(order, factory_id, user_id, description) unless order.packs.first.buying_price.blank?
      end
      
      if  !qc.blank? 
       order.qc = qc unless qc.blank?
      StatusMailer.deliver_quality(order, user_id, factory_id, description, qc)
      end
      order.factory_id = "NIL" unless unplaced.blank?
      order.statuses.create(:modifications => order.changes, :description => description, :pinned => pinned, :user_id => user_id, :changed_type => "Order", :changed_id => order.id, :occurred_on => Time.new) if !order.changes.values_blank? || !description.blank?
      order.save
    end
  end
end