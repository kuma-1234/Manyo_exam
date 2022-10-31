class AddIndexTaskTitleToTasks < ActiveRecord::Migration[6.1]
  def change
    add_index :tasks, :task_title
  end
end
