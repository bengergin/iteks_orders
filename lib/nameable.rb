module Nameable
  
  def name=(name)
    self.first_name, *other_names = name.split
    self.last_name = other_names.last
  end
  
  def name
    [first_name, last_name].compact.join(" ")
  end
end