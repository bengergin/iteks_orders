class AddAdditionalInformationToStatuses < ActiveRecord::Migration
  
  Status.class_eval do
    belongs_to :factory
    def to_s
      case category
      when 'other' then "#{additional_information} on #{occurred_on.strftime('%d/%m/%y')}"
      when 'placed' then "Placed on #{occurred_on.strftime('%d/%m/%y')} #{factory_id && 'with ' + factory.name} by #{user.name}"
      else "#{category.humanize} on #{occurred_on.strftime('%d/%m/%y')}#{additional_information.blank? ? '' : ": #{additional_information}"}"
      end
    end
  end
  
  def self.up
    change_table(:statuses) do |t|
      t.rename :description, :additional_information
      t.text :description
      t.text :modifications
      t.integer :changed_id
      t.string :changed_type
    end
    
    Status.reset_column_information
    Status.all.each do |s|
      s.description = s.to_s
      s.save
      case s.category
      when "red_seal_approved"
        s.order.packs.each do |d|
          d.update_attribute(:red_seal_approved_on, s.occurred_on)
        end
      when "testing_completed"
        s.order.packs.each do |d|
          d.update_attribute(:testing_completed_on, s.occurred_on)
        end
      when "packaging_approved"
        s.order.update_attribute(:packaging_approved_on, s.occurred_on)
      when "gold_seal_approved"
        s.order.packs.each do |d|
          d.update_attribute(:gold_seal_approved_on, s.occurred_on)
        end
      end
    end
  end

  def self.down
    change_table(:statuses) do |t|
      t.remove :description, :modifications, :changed_id, :changed_type
      t.rename :additional_information, :description
    end
  end
end
