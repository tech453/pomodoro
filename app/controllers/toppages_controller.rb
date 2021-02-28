class ToppagesController < ApplicationController
  def index
    if logged_in?
      @post = current_user.posts.build  
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      @memo = current_user.memos.build  
      @memos = current_user.memos.order(id: :desc).page(params[:page])
      @task = current_user.tasks.build  
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
  end
end