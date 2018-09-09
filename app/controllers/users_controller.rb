class UsersController < ApplicationController
  POSTS_PER_PAGE = 10

  def show
    @posts = current_user.posts.page(params[:page]).per(POSTS_PER_PAGE)
  end

end
