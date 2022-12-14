# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  email: 'test@test.com',
  name: '管理者',
  password: 'test1234',
  password_confirmation: 'test1234',
  admin: true
)

Task.create!(
  task_title: "title",
    task_content: "contentcontent",
    deadline: "2022-12-24",
    status: 2,
    priority: 3,
    user_id: 1
)

10.times do |n|
  User.create!(
    email: "email#{n}@test.com",
    name: "user#{n}",
    password: 'test321',
    password_confirmation: 'test321',
    admin: false
  )
end

10.times do |index|
  Label.create!(
    label_name: "label#{index}",
    user_id: 1
  )
end

10.times do |i|
  User.all.each do |user|
    user.tasks.create(
      task_title: "title#{i}",
      task_content: "content#{i}",
      deadline: rand(Date.new(2022,12,1)...Date.new(2022,12,31)),
      status: rand(1..3),
      priority: rand(1..3),
    )
  end
end