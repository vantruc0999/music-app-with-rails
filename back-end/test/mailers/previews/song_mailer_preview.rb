# Preview all emails at http://localhost:3000/rails/mailers/song_mailer
class SongMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/song_mailer/song_created
  def song_created
    SongMailer.with(user: User.find_by(id: 2), song: Song.first).song_created
  end

end
