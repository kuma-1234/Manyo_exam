FactoryBot.define do
  factory :user do
    name { 'user1' }
    email { 'user@test.com' }
    password { 'test123456' }
    admin { 'false' }
  end
  factory :user2, class: User do
    name { 'user2' }
    email { 'user2@test.com' }
    password { 'test123456' }
    admin { 'false' }
  end
  factory :admin_user, class: User do
    name { 'admin_user' }
    email { 'admin_user@test.com' }
    password { 'test123456' }
    admin { 'true' }
  end
end