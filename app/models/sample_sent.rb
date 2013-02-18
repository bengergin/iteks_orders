class SampleSent < SampleStatus
  after_save    :mark_sample_as_sent
  after_destroy :unmark_sample_as_sent
  
  def activity
    "sent from factory"
  end
  
  private
  def mark_sample_as_sent
    sample.update_attributes(:sent_on => occurred_on, :updated_by => updater)
  end
  
  def unmark_sample_as_sent
    sample.update_attributes(:sent_on => nil, :updated_by => updater)
  end
end