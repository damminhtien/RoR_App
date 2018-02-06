class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true,
    length: {maximum: Settings.max_email_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
   length: {minimum: Settings.min_password_length}
  validates :name, presence: true, length: {maximum: Settings.max_name_length}

  before_save :email_downcase

  has_secure_password

  class << self
    def digest string
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create string, cost: cost
    end
  end

  private

  def email_downcase
    email.downcase!
  end
end
