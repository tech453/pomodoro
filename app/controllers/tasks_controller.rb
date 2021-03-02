class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:edit,:destroy,:update]
  
  def edit

  end
  
  def update

    if @task.update(task_params)
      flash[:success] = 'タスクを更新しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'タスクの更新に失敗しました。'
      render 'edit'
    end
  end
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを作成しました。'
      redirect_to root_url
    else
      flash[:danger] = 'タスクの作成に失敗しました。'
      redirect_to root_url
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private
  
  def set_task
    @task=Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content)
  end

end
