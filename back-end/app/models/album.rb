class Album < ApplicationRecord
    has_many :songs
    belongs_to :artist

    has_one_attached :cover

    def cover_url
        Rails.application.routes.url_helpers.url_for(cover) if cover.attached?
    end
end
