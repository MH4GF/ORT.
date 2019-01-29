# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  POSTS_PER_PAGE = 10

  before_action :user_info, :move_to_about

  def user_info
    return unless user_signed_in?

    @user_posts = current_user.posts
    @total_running_time = SumRunningTimeService.new(@user_posts).call
    @having_tags = @user_posts.tag_counts
  end

  # ログインしていない場合はaboutへリダイレクト
  def move_to_about
    return if user_signed_in?

    flash[:notice] = 'ログインして、学習を始めよう！'
    redirect_to root_path
  end
end
