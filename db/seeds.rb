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

# 5.times do |num|
#     User.create!(
#     email: "test#{num}@sample.com",
#     name: "user#{num}",
#     password: 'test321',
#     password_confirmation: 'test321',
#     admin: false
#   )
# end

# User.all.each do |user|
#   user.tasks.create!(
#     task_title: "title",
#     task_content: "content",
#     deadline: Date,
#     status: rand(1..3),
#     priority: rand(1..3)
#   )
# end

# 5.times do |index|
#   Task.create!(
#     task_title: "title#{index}",
#     task_content: "content#{index}",
#     deadline: Date,
#     status: rand(1..3),
#     priority: rand(1..3),
#     user: @user
#   )
# end