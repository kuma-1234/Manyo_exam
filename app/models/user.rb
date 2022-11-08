class User < ApplicationRecord
  before_update :admin_cannot_update
  before_destroy :admin_cannot_delete

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }, on: :new
  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy


  private

  def admin_cannot_update
    @admin_user = User.where(admin: true)
    throw :abort if @admin_user.count == 1 && @admin_user.first == self && self.admin == false
  end

  def admin_cannot_delete
    throw :abort if User.where(admin: true).count == 1 && self.admin
  end
end