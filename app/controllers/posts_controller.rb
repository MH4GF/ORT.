class PostsController < ApplicationController


  before_action :move_to_about, except: [:about, :contact, :terms, :privacy]

  def about
  end

  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new
  end

  def tweet
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret      = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token         = current_user.token
      config.access_token_secret  = current_user.secret
    end
    # Twitter投稿
    client.update(tweet_contents)
    flash[:notice] = "投稿とツイートが完了しました。5分休憩しましょう！"
  end

  def tweet_contents
    return params[:content] +
           "【" + params[:running_time] + "分】" +
           "#ORT #インターネット勉強班 "
  end

  def create
    @post = Post.new(content: create_params[:content], running_time: create_params[:running_time], tag_list: create_params[:tag_list], user_id: current_user.id)
    if @post.save
      flash[:notice] = "投稿を作成しました。5分休憩しましょう！"
    if params[:tweet_toggle] === "true"
      tweet
    end
    if @post.tag_list != []
      latest_post = Post.all.last
      tag = ActsAsTaggableOn::Tagging.find_by(taggable_id: latest_post.id)
      redirect_to("/tags/#{tag.tag_id}")
    else
      redirect_to("/users/mypage")
    end
    else

      # バリデーションに引っかかり投稿ページにリダイレクトする場合は、モーダルを出さない
      @display_none = "display_none"

      render("posts/new")
    end

  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.running_time = params[:running_time]
    @post.tag_list = params[:tag_list]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/users/mypage")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/users/mypage")
  end

  def contact
  end

  def terms
  end

  def privacy
  end
private
  def create_params
    params.permit(:content, :running_time, :tag_list)
  end

end
