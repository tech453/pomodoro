class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy,:edit,:create]
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'メモを作成しました'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メモの作成に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def edit
    @task=Task.find(params[:id])
  end
  
  def update
    @task=Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = 'メモを更新しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'メモの更新ができませんでした。'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'メモを削除しました。'
    redirect_to root_url
  end

  private

  def task_params
    params.require(:task).permit(:content)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
