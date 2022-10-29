class Task < ApplicationRecord
  validates :task_title, presence: true
  validates :task_content, presence: true

  enum status: { 未着手: 1, 着手中: 2, 完了: 3 }
  
  scope :search, -> (search_params) do
    return if search_params.blank?
    search_title(search_params[:task_title])
  end

  scope :search_title, -> (task_title) {where("task_title LIKE ?", "%#{task_title}%")}
end
