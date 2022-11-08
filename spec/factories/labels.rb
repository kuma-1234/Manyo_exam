FactoryBot.define do
  factory :label do
    label_name { 'Ruby' }
  end
  factory :label2, class: Label do
    label_name { 'Rails' }
  end
end
