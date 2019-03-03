# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  POSTS_PER_PAGE = 10

  before_action :move_to_about

  def move_to_about
    return if user_signed_in?

    flash[:notice] = 'ログインして、学習を始めよう！'
    redirect_to root_path
  end
end
