class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(content: params[:content], running_time: params[:running_time])
    if @post.save
      if params[:tweet_toggle] === "true"
        flash[:notice] = "投稿を作成しました"
      end
      redirect_to("/posts/index")
    else
      render("posts/new")
    end

  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

  def tweet
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret      = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token         = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret  = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
    # Twitter投稿
    client.update(params[:content])
    flash[:notice] = "ツイートを投稿しました"
    redirect_to("/posts/index")
  end
end
