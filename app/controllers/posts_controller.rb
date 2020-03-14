class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create, :destroy]
  before_action :current_user,   only: :destroy
  
  
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
  end
  
  def destroy
  end
  
  private
  
    def post_params
      params.require(:post).permit(:context, :brand, :category, :rate, :sex, :picture, :product_name)
    end
  
end
