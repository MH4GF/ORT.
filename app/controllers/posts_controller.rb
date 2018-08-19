class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = current_user.posts.new(posts_params)

    if @post.save
      flash[:notice] = "投稿を作成しました。5分休憩しましょう！"
      tweet if params[:tweet_toggle]

      if @post.tags.present?
        redirect_to tag_path(tags.first.id)
      else
        redirect_to user_root_path
      end

    else
      render :new
    end
  end

  def update
    if @post.update(posts_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to user_root_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to user_root_path
  end

  private

  def posts_params
    params.require(:post).permit(:content, :running_time, :tag_list)
  end

  def find_post
    @post = Post.find_by(id: params[:id])
  end

  # ツイートトグルが有効の場合ツイート
  def tweet
    @post.tweet
    flash[:notice] = "投稿とツイートが完了しました。5分休憩しましょう！"
  end
end
