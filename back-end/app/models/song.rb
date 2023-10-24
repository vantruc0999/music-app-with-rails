class Song < ApplicationRecord
    has_and_belongs_to_many :playlists
    belongs_to :album
    belongs_to :genre
    belongs_to :artist
    has_many :favorites,
    has_many :users, through: :favorites
end
