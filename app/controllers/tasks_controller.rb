class TasksController < ApplicationController
  include SessionsHelper
  
  before_action :require_user_logged_in
  
  def index
    @tasks=current_user.tasks.all
  end
  
  def show
    @task=Task.find(params[:id])
  end
  
  def new
    @task=current_user.tasks.build
  end
  
  def create
    @task=current_user.tasks.new(task_params)
    if @task.save
      flash[:success]='タスクが作成されました。'
      redirect_to @task
    else
      flash.now[:danger]='タスク作成に失敗しました。'
      render :new
    end
  end
  
  def edit
    @task=Task.find(params[:id])
  end
  
  def update
    @task=Task.find(params[:id])
    if @task.update(task_params)
      flash[:success]='タスクが更新されました。'
      redirect_to @task
    else
      flash.now[:danger]='タスク更新が失敗しました。'
      render :edit
    end
  end
  
  def destroy
    @task=Task.find(params[:id])
    @task.destroy
    flash[:success]='タスクが削除されました。'
    redirect_to tasks_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
