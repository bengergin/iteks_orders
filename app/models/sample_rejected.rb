class SampleRejected < SampleStatus
  
  after_save    :unmark_sample_as_completed
  
  def activity
    "rejected"
  end
  
  private
  def unmark_sample_as_completed
    sample.update_attributes(:completed_on => nil, :updated_by => updater)
  end
end