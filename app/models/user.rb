class User < ApplicationRecord
  before_update :admin_cannot_update
  before_destroy :admin_cannot_delete

  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }, on: :new
  has_many :tasks, dependent: :destroy


  private

  def admin_cannot_update
    throw :abort if User.where(admin: true).count == 1 && self.admin == false
  end

  def admin_cannot_delete
    throw :abort if User.where(admin: true).count == 1 && self.admin
  end
end