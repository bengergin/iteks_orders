class Factory < ActiveRecord::Base

  validates_uniqueness_of :name, :scope => :country_id
  belongs_to :country
  has_many :orders
  has_many :roles, :as => :company
  has_many :people, :through => :roles do
    def owner
      find(:first, :conditions => "roles.title = 'Owner'")
    end
  end
  
  after_update :save_roles
  
  def short_name
    name[0..30]
  end
  
  def new_role_attributes=(role_attributes)
    role_attributes.each do |attributes|
      roles.build(attributes) unless attributes.values_blank?
    end
  end
  
  def existing_role_attributes=(role_attributes)
    roles.reject(&:new_record?).each do |role|
      attributes = role_attributes[role.id.to_s]
      if attributes
        role.attributes = attributes
      else
        roles.delete(role)
      end
    end
  end
  
  def save_roles
    roles.each do |role|
      role.save(false)
    end
  end
end
