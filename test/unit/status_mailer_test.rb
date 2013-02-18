require 'test_helper'

class StatusMailerTest < ActionMailer::TestCase
  tests StatusMailer
  def test_factory
    @expected.subject = 'StatusMailer#factory'
    @expected.body    = read_fixture('factory')
    @expected.date    = Time.now

    assert_equal @expected.encoded, StatusMailer.create_factory(@expected.date).encoded
  end

end
