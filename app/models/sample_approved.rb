class SampleApproved < SampleStatus
  
  after_save    :mark_sample_as_completed
  after_destroy :unmark_sample_as_completed
  
  def activity
    "approved"
  end
  
  private
  def mark_sample_as_completed
    sample.update_attributes(:completed_on => occurred_on, :updated_by => updater)
  end
  
  def unmark_sample_as_completed
    sample.update_attributes(:completed_on => nil, :updated_by => updater)
  end
end