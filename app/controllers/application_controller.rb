class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :tags, :sum_running_time, except: :about

  def tags
    @all_tags = ActsAsTaggableOn::Tag.all
  end

  def sum_running_time
    if current_user === nil
      return
    end

    @sum = 0
    @user_posts = User.find_by(id: current_user.id).posts

    @user_posts.each do |u_post|
      @sum += u_post.running_time.to_i
    end

    @hour = @sum / 60
    @min = @sum % 60

  end

  def move_to_about
    unless user_signed_in? then
      flash[:notice] = "ログインして、学習を始めよう！"
      redirect_to controller: 'posts', action: 'about'
    end
  end
end
