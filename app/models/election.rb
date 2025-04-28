# frozen_string_literal: true

# Election Model
class Election < ApplicationRecord
  has_many :candidates
end
