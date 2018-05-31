class ApplicationController < ActionController::Base
  # CSRF対策
  protect_from_forgery with: :exception

  before_action :tags, :sum_running_time

  def posts
    @posts = current_user.posts.order(created_at: :desc)
  end

  def tags
    if current_user === nil
      return
    end

    @all_tags = ActsAsTaggableOn::Tag.all
  end

  # 累計時間を計算
  def sum_running_time
    if current_user === nil
      return
    end

    @sum = 0

    # postsに入っている投稿の配列から、running_timeカラムに入っている時間を@sumに足していく
    posts.each do |u_post|
      @sum += u_post.running_time.to_i
    end

    @hour = @sum / 60
    @min = @sum % 60
  end

  # ログインしていない場合はaboutへリダイレクト
  def move_to_about
    unless user_signed_in? then
      flash[:notice] = "ログインして、学習を始めよう！"
      redirect_to controller: 'posts', action: 'about'
    end
  end

end
