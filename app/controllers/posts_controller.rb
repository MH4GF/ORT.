class PostsController < ApplicationController


  def new
    @post = Post.new
    @default_time       = current_user.default_time
    @allow_linked_tweet = current_user.allow_linked_tweet
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

  # ツイート内容
  def tweet_contents
    return create_params[:content] +
           "【" + create_params[:running_time] + "分】" +
           "#インターネット勉強班 @ORT_pomodoro"
  end


  def create
    @post = Post.new(content:      create_params[:content],
                     running_time: create_params[:running_time],
                     tag_list:     create_params[:tag_list],
                     user_id:      current_user.id)

    if @post.save
      flash[:notice] = "投稿を作成しました。5分休憩しましょう！"

      # ツイートトグルが有効の場合ツイート
      if params[:tweet_toggle] === "true"
        tweet
      end

      # タグがある場合はタグ一覧ページにリダイレクトし、ない場合はマイページへリダイレクト
      if @post.tag_list != []
        latest_post = Post.all.last
        tag = ActsAsTaggableOn::Tagging.find_by(taggable_id: latest_post.id)
        redirect_to("/tags/#{tag.tag_id}")
      else
        redirect_to("/users/mypage")
      end

    else

      # 投稿ページにリダイレクトするならタイマーのモーダルは出さない
      # FIXME なんだこれ
      @display_none = "display_none"

      render("posts/new")

    end

  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])

    @post.content       = create_params[:content]
    @post.running_time  = create_params[:running_time]
    @post.tag_list      = create_params[:tag_list]

    # 投稿が保存できたかどうかで条件分岐
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

private
  # ストロングパラメーター
  def create_params
    params.require(:post).permit(:content, :running_time, :tag_list)
  end
end
