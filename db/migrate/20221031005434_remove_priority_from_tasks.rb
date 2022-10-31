class RemovePriorityFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :priority, :string
  end
end
