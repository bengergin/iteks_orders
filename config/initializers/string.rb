class String
  def is_i?
    !!Integer(self) rescue false
  end

  def is_active_record?
    self.classify.constantize
  rescue
    false
  end
  
  def strip_tags
    gsub(/<\/?[^>]*>/, "")
  end
end