class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :user_info, :move_to_about

  def user_info
    return unless user_signed_in?

    # TODO: 変数名が重複するので一旦 @user_posts にする
    @user_posts         = current_user.posts.order(created_at: :desc)
    @total_running_time = SumRunningTimeService.new(@user_posts).call
    @having_tags        = @user_posts.tag_counts
  end

  # ログインしていない場合はaboutへリダイレクト
  def move_to_about
    unless user_signed_in?
      flash[:notice] = "ログインして、学習を始めよう！"
      redirect_to root_path
    end
  end
end
