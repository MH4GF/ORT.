class UsersController < ApplicationController

  before_action :move_to_about

  def show
    @posts = current_user.posts.order(created_at: :desc)
  end

end
