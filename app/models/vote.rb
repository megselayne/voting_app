class Vote < ApplicationRecord
    # user_id
    # candidate_id (fk)
    # election_id (fk)
    belongs_to :candidate
    belongs_to :election
  end
  