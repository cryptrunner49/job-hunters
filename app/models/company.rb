class Company < ApplicationRecord
  has_many :job_posts, dependent: :destroy
  has_many :job_applications, through: :job_posts

  def soft_delete
    update(deleted: true)
  end
end
