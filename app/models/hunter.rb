class Hunter < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :resumes, dependent: :destroy
  has_many :cover_letters, dependent: :destroy
  has_many :job_applications, dependent: :destroy
  has_many :job_offers, dependent: :destroy
  has_one_attached :profile_picture

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true

  def soft_delete
    update(deleted: true)
  end
end
