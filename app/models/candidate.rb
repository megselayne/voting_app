# frozen_string_literal: true

# Candidate Model
class Candidate < ApplicationRecord
  belongs_to :election

  validate :election_candidate_limit

  # Prevents more than 10 candidates being added per election
  def election_candidate_limit
    return unless election.candidates.count >= 10

    errors.add(:base, 'An election cannot have more than 10 candidates.')
  end
end
