module OrdersHelper
  def dispatch_prefix(dispatch)
    "order[#{new_or_existing(dispatch)}_dispatch_attributes][#{dispatch.number}]"
  end
  
  def dispatch_quantity_prefix(dispatch, dispatch_quantity)
    "#{dispatch_prefix(dispatch)}[#{new_or_existing(dispatch_quantity)}_dispatch_quantity_attributes][]"
  end
  
  def pack_prefix(pack)
    "order[#{new_or_existing(pack)}_pack_attributes][#{pack.letter}]"
  end
  
  def pack_add_on_prefix(pack, pack_add_on)
    "#{pack_prefix(pack)}[#{new_or_existing(pack_add_on)}_pack_add_on_attributes][]"
  end
  
  def pack_size_prefix(pack, pack_size)
    "#{pack_prefix(pack)}[#{new_or_existing(pack_size)}_pack_size_attributes][]"
  end

  def status(dispatch)
    status = ""
    status << '<span class="red_seal_approved">R</span> '   if dispatch.red_seal_approved_on?
    status << '<span class="testing_completed">T</span> '   if dispatch.testing_completed_on?
    status << '<span class="packaging_approved">P</span> '  if dispatch.packaging_approved_on?
    status << '<span class="gold_seal_approved">G</span> '  if dispatch.gold_seal_approved_on?
    status
  end
  
  def per(per)
    case per
    when 0 then "pack"
    when 1 then "pair"
    when 2 then "dozen"
    end
  end
end
