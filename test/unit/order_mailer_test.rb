require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  tests OrderMailer
  def test_gonul
    @expected.subject = 'OrderMailer#gonul'
    @expected.body    = read_fixture('gonul')
    @expected.date    = Time.now

    assert_equal @expected.encoded, OrderMailer.create_gonul(@expected.date).encoded
  end

end
