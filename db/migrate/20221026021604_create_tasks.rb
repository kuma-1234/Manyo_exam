class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :task_title
      t.text :task_content

      t.timestamps
    end
  end
end
