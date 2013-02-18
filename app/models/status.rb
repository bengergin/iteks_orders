class Status < ActiveRecord::Base
  PRICE_PER_PACK = 0
  PRICE_PER_PAIR = 1
  PRICE_PER_DOZEN = 2
  
  belongs_to :order
  belongs_to :user
  
  serialize :modifications
  
  def buying_price_per_pair_in_gbp
    price = case price_per
      when PRICE_PER_PAIR  then buying_price
      when PRICE_PER_PACK  then buying_price / order.quantity_per_pack
      when PRICE_PER_DOZEN then buying_price / 12
    end
    
    if currency == '£'
      price
    else
      price / exchange_rate
    end
  end
  
  def buying_price_per_pack_in_gbp
    if price_per == PRICE_PER_PACK
      buying_price / exchange_rate
    else
      buying_price_per_pair_in_gbp * order.quantity_per_pack
    end
  end
  
  def buying_price_per_dozen_in_gbp
    if price_per == PRICE_PER_DOZEN
      buying_price
    else
      buying_price_per_pair_in_gbp * 12
    end
  end
end
