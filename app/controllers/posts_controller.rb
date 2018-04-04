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

  def tweet
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret      = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token         = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret  = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
    # Twitter投稿
    client.update(tweet_contents)
    flash[:notice] = "投稿とツイートが完了しました"
  end

  def tweet_contents
    return params[:content] +
           "【" + params[:running_time] + "分】" +
           "#ORT #インターネット勉強班 " +
           "#" + @post.tag_list.first + " "
  end

  def create
    @post = Post.new(create_params)
    if @post.save
      flash[:notice] = "投稿を作成しました"
    if params[:tweet_toggle] === "true"
      tweet
    end
    if @post.tag_list != []
      latest_post = Post.all.last
      tag = ActsAsTaggableOn::Tagging.find_by(taggable_id: latest_post.id)
      redirect_to("/tags/#{tag.tag_id}")
    else
      redirect_to("/posts/index")
    end
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

private
  def create_params
    params.permit(:content, :running_time, :tag_list)
  end
end
