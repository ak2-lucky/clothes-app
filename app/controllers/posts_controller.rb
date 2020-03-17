class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :destroy]
  before_action :current_user,   only: :destroy
  
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(5)
  end
  
  def new
    @post = current_user.posts.build if user_signed_in?
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_url
    else
      render 'posts/new'
    end
  end
  
  def show
    @post = Post.find_by(id: params[:id])
  end
  
  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url
  end
  
  private
  
    def post_params
      params.require(:post).permit(:context, :brand, :category, :rate, :sex, :picture, :product_name)
    end
  
end
