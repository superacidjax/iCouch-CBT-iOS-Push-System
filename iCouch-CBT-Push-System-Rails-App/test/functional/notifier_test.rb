require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "record_submit" do
    mail = Notifier.record_submit
    assert_equal "Record submit", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
