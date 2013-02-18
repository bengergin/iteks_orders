module SamplesHelper
  def sample_add_on_prefix(sample_add_on)
    "sample[#{new_or_existing(sample_add_on)}_sample_add_on_attributes][]"
  end
end
