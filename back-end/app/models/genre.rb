class Genre < ApplicationRecord
    has_many :songs

    validates :name, presence: {messsage: "Genre name can not be blank"}, length: { in: 2..255, message: "Genre name must be between 2 and 50 characters long." }, uniqueness: { message: "Genre name is already taken." }
end
