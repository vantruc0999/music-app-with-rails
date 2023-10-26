class Album < ApplicationRecord
    has_many :songs
    belongs_to :artist

    has_one_attached :cover

    validates :name, presence: {messsage: "Album name can not be blank"}, length: { in: 2..255, message: "Artist name must be between 2 and 255 characters long." }
    validates :artist_id, presence: {messsage: "Artist can not be blank"}

    def cover_url
        Rails.application.routes.url_helpers.url_for(cover) if cover.attached?
    end
end
