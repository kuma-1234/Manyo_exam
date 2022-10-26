class Task < ApplicationRecord
  validates :task_title, presence: true
  validates :task_content, presence: true
end
