require "test_helper"

class SongMailerTest < ActionMailer::TestCase
  test "song_created" do
    mail = SongMailer.song_created
    assert_equal "Song created", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
