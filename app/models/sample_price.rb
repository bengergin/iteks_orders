class SamplePrice < SampleStatus
  after_save    :add_sample_price
  has_and_belongs_to_many :exchange_rates
  


  def activity
    "price"
  end
  
  private
  def add_sample_price
    if !currency?
    currency = ExchangeRate.find_by_id(exchange_rate_id).rate
    end
    sample.update_attributes(:price => buying_price, :exchange_rate_id => exchange_rate_id, :price_per => price_per, :currency => currency, :updated_by => updater)
    SampleMailer.deliver_price(sample) 
  end
end
