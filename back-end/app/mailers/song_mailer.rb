class SongMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.song_mailer.song_created.subject
  #
  def song_created
    @user = params[:user]
    @song = params[:song]
    @greeting = "Suppp"
    attachments['ong-putin-16797989949601625139011.jpg'] = File.read('app/assets/images/ong-putin-16797989949601625139011.jpg')
    mail(
      to: email_address_with_name(User.find_by(id: 2).email, User.find_by(id: 2).email),
      cc: User.find(1).email,
      # cc: User.all.pluck(:email),
      subject: "New song created"
    )   
  end
end
