class AddColumToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :deadline, :date, null: false, default: -> { '(CURRENT_DATE)' }
    add_column :tasks, :status, :string
    add_column :tasks, :priority, :string
  end
end
