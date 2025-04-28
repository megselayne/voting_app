# frozen_string_literal: true

# Vote Model
class Vote < ApplicationRecord
  # user_id
  # candidate_id (fk)
  # election_id (fk)
  belongs_to :candidate
  belongs_to :election
  belongs_to :user

  # User can only vote once per election
  validates :user_id,
            uniqueness: { scope: :election_id, message: 'already voted in this election. Thanks for voting!' }
end
