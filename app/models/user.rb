class User < ApplicationRecord
    has_many :user_movies
    has_many :movies, through: :user_movies
    has_many :comments
    has_secure_password
    validates :username, uniqueness: true
end
