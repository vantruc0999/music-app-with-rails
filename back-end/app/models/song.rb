class Song < ApplicationRecord
    has_and_belongs_to_many :playlists
    belongs_to :album, optional: true
    belongs_to :genre, optional: true
    has_many :song_artists, dependent: :destroy
    has_many :artists, through: :song_artists
    has_many :favorites
    has_many :users, through: :favorites
    has_one_attached :song_image
    has_one_attached :audio

    validates :name, presence:  {messsage: "Song name can not be blank"}, length: { in: 2..255, message: "Song name must be between 2 and 255 characters long." }
    validates :duration, numericality: { greater_than: 0 }
    validates :release_year, numericality: { only_integer: true, message: "must be an integer number" }
    validates :genre_id, presence: true
    validates :audio, presence: true
    validates :song_image, presence: true

    def image_url
        Rails.application.routes.url_helpers.url_for(song_image) if song_image.attached?
        # Rails.application.routes.url_helpers.rails_blob_url(song_image, only_path: true) if song_image.attached?
    end

    def audio_url
        Rails.application.routes.url_helpers.url_for(audio) if audio.attached?
        # Rails.application.routes.url_helpers.rails_blob_url(audio, only_path: true) if audio.attached?
    end
end
