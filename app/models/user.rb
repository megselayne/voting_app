# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  # No duplicate emails across users
  validates :email, presence: true, uniqueness: true
end
