class ChangeColumnsNotnullAddTasks < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :task_title, false
    change_column_null :tasks, :task_content, false
  end
end
