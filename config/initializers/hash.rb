class Hash
  include Blankable
  alias blankable_values values

  def hash
    keys.hash + values.hash + (default ? default.hash : 0)
  end
  
  def eql?(other)
    hash == other.hash
  end
end