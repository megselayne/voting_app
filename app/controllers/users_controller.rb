# frozen_string_literal: true

# User controller
class UsersController < ApplicationController
  def create
    # Find or create by to get around sign up/ sign in flow
    user = User.find_or_create_by!(email: params[:email], zip_code: params[:zip_code])
    session[:user_id] = user.id
    redirect_to election_vote_path(Election.first.slug)
  rescue ActiveRecord::RecordInvalid
    @flash_alert = 'Error: Email already exists with different zip code.'
    render :login
  end

  def login
    redirect_to election_vote_path(Election.first.slug) if session[:user_id]
  end

  # Clear session
  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end
