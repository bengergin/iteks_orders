class Numeric
  def in_dozens
    ("%.2f" % (self / 12.0)).to_f
  end
end