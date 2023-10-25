class Artist < ApplicationRecord
    has_many :songs
    has_many :albums

    has_one_attached :artist_image

    def artist_image_url
        Rails.application.routes.url_helpers.url_for(artist_image) if artist_image.attached?
    end
end
