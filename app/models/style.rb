class Style < ActiveRecord::Base
  validates_uniqueness_of :name
  has_many   :orders
  belongs_to :product
  
  after_save :save_dispatches
  
  def save_dispatches
    orders.each do |order|
      order.dispatches.each do |dispatch| 
        if dispatch.product != product
          dispatch.save(false)
        end
      end
    end
  end
end