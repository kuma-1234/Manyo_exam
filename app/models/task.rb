class Task < ApplicationRecord
  validates :task_title, presence: true
  validates :task_content, presence: true
  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings

  enum status: { 未着手:1, 着手中:2, 完了:3 }
  enum priority: { 低:1, 中:2, 高:3 }
  
  scope :search, -> (search_params) do
    return if search_params.blank?
    search_title(search_params[:task_title])
      .search_status(search_params[:status])
  end

  scope :search_title, -> (task_title) {where("task_title LIKE ?", "%#{task_title}%") if task_title.present?}
  scope :search_status, -> (status) {where(status: status) if status.present?}
end
