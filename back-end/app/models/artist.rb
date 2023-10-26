class Artist < ApplicationRecord
    has_many :song_artists
    has_many :songs, through: :song_artists
    
    has_many :albums

    has_one_attached :artist_image

    validates :name, presence: {messsage: "Artist name can not be blank"}, length: { in: 2..255, message: "Artist name must be between 2 and 255 characters long." }

    def artist_image_url
        Rails.application.routes.url_helpers.url_for(artist_image) if artist_image.attached?
    end
end
