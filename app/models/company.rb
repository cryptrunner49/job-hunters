class Company < ApplicationRecord
  has_many :job_posts, dependent: :destroy

  def soft_delete
    update(deleted: true)
  end
end
