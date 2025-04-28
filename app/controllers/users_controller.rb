# frozen_string_literal: true

# User controller
class UsersController < ApplicationController
  def create
    # Find or create by to get around sign up/ sign in flow
    user = User.find_or_create_by!(email: params[:email], zip_code: params[:zip_code])
    session[:user_id] = user.id
    redirect_to election_vote_path(Election.first.slug)
  rescue ActiveRecord::RecordInvalid
    flash[:alert] = 'Error: Email already exists with different zip code.'
    redirect_to login_path
  end

  def login
    @flash_alert = flash[:alert]
    redirect_to election_vote_path(Election.first.slug) if session[:user_id]
  end

  # Clear session
  def logout
    session[:user_id] = nil
    redirect_to login_path
  end
end
