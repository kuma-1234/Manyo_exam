class TasksController < ApplicationController

  def index
    @tasks = current_user.tasks.order(created_at: :desc)
    #終了期限で降順にする場合↓
    @tasks = @tasks.reorder(deadline: :asc) if params[:sort_expired]
    #優先順位で降順にする場合↓
    @tasks = @tasks.reorder(priority: :desc) if params[:sort_priority]
    #タイトルのあいまい検索,ステータス検索
    @search_params = task_search_params
    @tasks = Task.search(@search_params) if params[:search].present?
    #kaminari gem
    @tasks = @tasks.page(params[:page])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to task_path(@task), notice: "タスクを作成しました！"
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_path(params[:id]), notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end


  private

  def task_params
    params.require(:task).permit(:task_title, :task_content, :created_at, :deadline, :status, :priority)
  end

  def task_search_params
    params.fetch(:search, {}).permit(:task_title, :status,)
  end

end
