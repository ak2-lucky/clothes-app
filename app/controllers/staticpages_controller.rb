class StaticpagesController < ApplicationController
  
  def home
    if signed_in?
      redirect_to posts_path
    end
  end
  
  def about
    if signed_in?
      redirect_to posts_path
    end
  end
end
