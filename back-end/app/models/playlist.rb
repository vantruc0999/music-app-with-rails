class Playlist < ApplicationRecord
    belongs_to :user
    has_and_belongs_to_many :songs
    
    validates :name, presence: {messsage: "Playlist name can not be blank"}, length: { in: 2..255, message: "Playlist name must be between 2 and 255 characters long." }
end
