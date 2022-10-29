FactoryBot.define do
  factory :task do
    task_title { 'test' }
    task_content { 'test' }
    deadline { '2022-10-29' }
  end
  factory :task2, class: Task do
    task_title { 'test2' }
    task_content { 'test2' }
    deadline { '2022-12-25' }
  end
end
