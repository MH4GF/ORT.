class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :user_info, :move_to_about

  def user_info
    return unless user_signed_in?

    @posts                = current_user.posts.order(created_at: :desc)
    @total_running_time   = SumRunningTimeService.new(@posts).call
    @having_tags          = @posts.tag_counts
  end

  # ログインしていない場合はaboutへリダイレクト
  def move_to_about
    unless user_signed_in?
      flash[:notice] = "ログインして、学習を始めよう！"
      redirect_to root_path
    end
  end
end
