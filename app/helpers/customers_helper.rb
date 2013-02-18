module CustomersHelper
  def role_prefix(role)
    "customer[#{new_or_existing(role)}_role_attributes][]"
  end
  
  def person_prefix(role)
    "#{role_prefix(role)}[person_attributes]"
  end
end
