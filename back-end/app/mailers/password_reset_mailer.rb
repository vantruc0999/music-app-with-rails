class PasswordResetMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_reset_mailer.password_reset.subject
  #
  def password_reset
    @user = params[:user]
    @url = params[:url]
    @mail = @user.email
    @greeting = "Suppp"
    attachments['ong-putin-16797989949601625139011.jpg'] = File.read('app/assets/images/ong-putin-16797989949601625139011.jpg')
    mail(
      to: email_address_with_name(@mail, @mail),
      subject: "Reset password"
    )  
  end
end
