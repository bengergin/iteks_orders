class Role < ActiveRecord::Base
  belongs_to :person
  belongs_to :company, :polymorphic => true
  belongs_to :factory, :foreign_key => "company_id"
  belongs_to :customer, :foreign_key => "company_id"
end
