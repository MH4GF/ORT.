class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :tags, :sum_running_time, except: :about

  def tags
    @all_tags = ActsAsTaggableOn::Tag.all
  end

  def sum_running_time
    @sum = 0
    @user_posts = current_user.posts

    @user_posts.each do |u_post|
      @sum += u_post.running_time.to_i
    end

    @hour = @sum / 60
    @min = @sum % 60

  end
end
