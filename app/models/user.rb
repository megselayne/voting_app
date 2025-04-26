class User < ApplicationRecord
    # No duplicate emails across users
    validates :email, presence: true, uniqueness: true
end