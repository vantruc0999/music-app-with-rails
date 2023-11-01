class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :favorites
  has_many :playlists
  has_many :songs, through: :favorites

  has_one_attached :avatar_image

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  enum role: %i[user admin]
  
  # the authenticate method from devise documentation
  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

  def avatar_image_url
    Rails.application.routes.url_helpers.url_for(avatar_image) if avatar_image.attached?
  end
end
