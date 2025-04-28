# frozen_string_literal: true

# Vote controller
class VotesController < ApplicationController
  # Vote cast saved to the db
  def create
    begin
      election = Election.find_by(slug: params[:election_slug])

      candidate = if params[:candidate_id]
                    # Voting for an existing candidate
                    Candidate.find(params[:candidate_id])
                  else
                    # Adding a new candidate
                    find_or_create_candidate(election, params[:candidate][:name])
                  end

      user = User.find_by(id: session[:user_id])
      Vote.create!(candidate: candidate, user: user, election: election)
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Validation failed: #{e.message}")

      # Flash and redirect
      @flash_alert = e.record.errors.full_messages.to_sentence
      redirect_to election_vote_path(election.slug)
    end
    redirect_to election_results_path(election.slug)
  end

  # Fuzzy matching and candidate creation logic
  def find_or_create_candidate(election, candidate_name)
    candidates = Candidate.where(election_id: election.id)

    # Use Levenshtein to find the closest existing candidate name
    closest_match = candidates.min_by do |candidate|
      Amatch::Levenshtein.new(candidate.name).match(candidate_name)
    end

    # Compare closest match to submitted candidate
    # If within threshold (set to 3), we consider it a match and return closest candidate
    # Rather than creating a new one
    if closest_match
      distance = Amatch::Levenshtein.new(closest_match.name).match(candidate_name)
      return closest_match if distance <= 3
    end

    # Create a new candidate if no similar candidate is found
    Candidate.create!(name: candidate_name, election_id: election.id)
  end

  def already_voted?(election)
    Vote.exists?(user_id: session[:user_id], election_id: election.id)
  end

  # Show page to vote in an election
  def new
    # Prevent users manually trying to access voting page without logging in
    redirect_to login_path unless session[:user_id]

    @election = Election.find_by(slug: params[:election_slug])
    redirect_to election_results_path(@election.slug) if already_voted?(@election)

    @candidates = Candidate.where(election_id: @election.id)
  end
end
