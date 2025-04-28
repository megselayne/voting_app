# frozen_string_literal: true

# Results controller
class ResultsController < ApplicationController
  def show
    # Election name is not currently in designs, but could be relevant later
    @election = Election.find_by(slug: params[:election_slug])
    @results = Vote.where(election: @election)
                   .joins(:candidate)
                   .group('candidates.name')
                   .count
  end
end
