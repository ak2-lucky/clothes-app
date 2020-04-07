class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :destroy]
  before_action :current_user, only: :destroy

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result.includes(:user).page(params[:page]).per(5)
  end

  def new
    @post = current_user.posts.build if user_signed_in?
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿が完了しました。"
      redirect_to posts_path
    else
      render 'posts/new'
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @comment = Comment.new
    @comments = @post.comments
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "投稿を削除しました。"
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:content, :brand, :category, :rate, :sex, :picture, :product_name)
  end
end
