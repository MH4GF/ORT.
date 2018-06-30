class ApplicationController < ActionController::Base
  # CSRF対策
  protect_from_forgery with: :exception

  before_action :posts, :tags, :move_to_about

  def posts
    if current_user === nil
      return
    end

    @posts = current_user.posts.order(created_at: :desc)
    sum_running_time(@posts)
    @posts_hour = @sum / 60
    @posts_min = @sum % 60
  end

  def tags
    if current_user === nil
      return
    end

    @all_tags = ActsAsTaggableOn::Tag.all
  end

  # 累計時間を計算
  def sum_running_time(some_posts)
    if current_user === nil
      return
    end

    @sum = 0

    # postsに入っている投稿の配列から、running_timeカラムに入っている時間を@sumに足していく
    some_posts.each do |post|
      @sum += post.running_time.to_i
    end

  end

  # ログインしていない場合はaboutへリダイレクト
  def move_to_about
    unless user_signed_in?
      flash[:notice] = "ログインして、学習を始めよう！"
      redirect_to controller: 'docs', action: 'about'
    end
  end

end
