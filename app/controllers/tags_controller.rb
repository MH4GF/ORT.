class TagsController < ApplicationController
  def show
    @tag                = ActsAsTaggableOn::Tag.find_by(id: params[:id])
    @tagged_with_posts  = current_user.posts.tagged_with(@tag).order(created_at: :desc)
    @total_running_time = SumRunningTimeService.new(@tagged_with_posts).call
  end
end
