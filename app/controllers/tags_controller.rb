class TagsController < ApplicationController

before_action :move_to_about

def index
end

def show
  @id = ActsAsTaggableOn::Tag.find_by(id: params[:id])
  @tagged_with_posts = current_user.posts.tagged_with(@id).order(created_at: :desc)
  sum_running_time(@tagged_with_posts)
end


end
