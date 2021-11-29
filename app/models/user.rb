class User < ApplicationRecord
    has_many :articles
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :username, uniqueness: {case_sensitive: false}, 
                            presence: true, length: {minimum: 3, maximum: 25}
    validates :email, uniqueness: {case_sensitive: false}, 
                        presence: true, length: {maximum: 105},
                        format: { with: VALID_EMAIL_REGEX }
end