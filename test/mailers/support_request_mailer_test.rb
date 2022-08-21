require "test_helper"

class SupportRequestMailerTest < ActionMailer::TestCase
  test "respond" do
    mail = SupportRequestMailer.respond(support_requests(:one))
    assert_equal "Re: ", mail.subject
    assert_equal [], mail.to
    assert_equal ["support@example.com"], mail.from
    assert_match "", mail.body.encoded
  end

end
