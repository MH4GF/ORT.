class PostsController < ApplicationController

  def new
    @post               = Post.new
    @default_time       = current_user.default_time
    @allow_linked_tweet = current_user.allow_linked_tweet
  end

  def create
    @post = current_user.posts.new(create_params)
    byebug
    if @post.save
      flash[:notice] = "投稿を作成しました。5分休憩しましょう！"

      # ツイートトグルが有効の場合ツイート
      if params[:tweet_toggle]
        @post.tweet
        flash[:notice] = "投稿とツイートが完了しました。5分休憩しましょう！"
      end

      if @post.tags.present?
        redirect_to tag_path(tags.first.id)
      else
        redirect_to user_root_path
      end
    else
      render :new

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
      redirect_to user_root_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to user_root_path
  end

  private

  def create_params
    params.require(:post).permit(:content, :running_time, :tag_list)
  end
end
