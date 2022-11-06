class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :labeling.tasks, through: :labelings, source: :task
end
