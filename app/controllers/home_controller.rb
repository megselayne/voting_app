# frozen_string_literal: true

# Home controller
class HomeController < ApplicationController
  def index
    # If user is signed in, redirect to election show page
    # If not, send to log in page
    if session[:user_id]
      # No election index page currently, so let's grab the default election
      election = Election.first
      redirect_to election_vote_path(election.slug)
    else
      redirect_to login_path
    end
  end
end
