class AddFactoryIdAndPlacedOnAndCriticalPathToOrders < ActiveRecord::Migration
  
  def self.up
    change_table(:orders) do |t|
      t.references :factory, :company
      t.date       :placed_on,
                   :placed_by,
                   :red_seal_received_on,
                   :red_seal_received_by,
                   :red_seal_approved_on,
                   :red_seal_approved_by,
                   :gold_seal_received_on,
                   :gold_seal_received_by,
                   :gold_seal_approved_on,
                   :gold_seal_approved_by,
                   :testing_completed_on,
                   :testing_completed_by,
                   :bulk_yarn_ordered_on,
                   :bulk_yarn_ordered_by,
                   :fibre_composition_received_on,
                   :fibre_composition_received_by,
                   :packaging_proof_sent_on,
                   :packaging_proof_sent_by,
                   :packaging_approved_on,
                   :packaging_approved_by,
                   :bulk_yarn_arrived_on,
                   :bulk_yarn_arrived_by,
                   :knitting_started_on,
                   :knitting_started_by
      
      t.index      :company_id
      t.index      :factory_id
      t.index      :placed_on
      t.index      :placed_by
      t.index      :red_seal_approved_on
      t.index      :red_seal_approved_by
      t.index      :gold_seal_approved_on
      t.index      :gold_seal_approved_by
      t.index      :testing_completed_on
      t.index      :testing_completed_by
      t.index      :bulk_yarn_ordered_on
      t.index      :bulk_yarn_ordered_by
      t.index      :fibre_composition_received_on
      t.index      :fibre_composition_received_by
      t.index      :packaging_proof_sent_on
      t.index      :packaging_proof_sent_by
      t.index      :packaging_approved_on
      t.index      :packaging_approved_by
      t.index      :bulk_yarn_arrived_on
      t.index      :bulk_yarn_arrived_by
      t.index      :knitting_started_on
      t.index      :knitting_started_by
    end
    
    Order.all.each do |order|
      placement = order.statuses.try(:find, :first, :conditions => 'category = "placed"', :order => "created_at DESC")
      order.placed_on = placement.try(:occurred_on)
      order.factory_id = placement.try(:factory_id)
      order.save
    end
  end

  def self.down
    change_table(:orders) do |t|
      t.remove_references :factory, :company
      t.remove            :placed_on,
                          :placed_by,
                          :red_seal_approved_on,
                          :red_seal_approved_by,
                          :gold_seal_approved_on,
                          :gold_seal_approved_by,
                          :testing_completed_on,
                          :testing_completed_by,
                          :bulk_yarn_ordered_on,
                          :bulk_yarn_ordered_by,
                          :fibre_composition_received_on,
                          :fibre_composition_received_by,
                          :packaging_proof_sent_on,
                          :packaging_proof_sent_by,
                          :packaging_approved_on,
                          :packaging_approved_by,
                          :bulk_yarn_arrived_on,
                          :bulk_yarn_arrived_by,
                          :knitting_started_on,
                          :knitting_started_by
      
      t.remove_index      :company_id
      t.remove_index      :factory_id
      t.remove_index      :placed_on
      t.remove_index      :placed_by
      t.remove_index      :red_seal_approved_on
      t.remove_index      :red_seal_approved_by
      t.remove_index      :gold_seal_approved_on
      t.remove_index      :gold_seal_approved_by
      t.remove_index      :testing_completed_on
      t.remove_index      :testing_completed_by
      t.remove_index      :bulk_yarn_ordered_on
      t.remove_index      :bulk_yarn_ordered_by
      t.remove_index      :fibre_composition_received_on
      t.remove_index      :fibre_composition_received_by
      t.remove_index      :packaging_proof_sent_on
      t.remove_index      :packaging_proof_sent_by
      t.remove_index      :packaging_approved_on
      t.remove_index      :packaging_approved_by
      t.remove_index      :bulk_yarn_arrived_on
      t.remove_index      :bulk_yarn_arrived_by
      t.remove_index      :knitting_started_on
      t.remove_index      :knitting_started_by
    end
  end
end
