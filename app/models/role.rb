class Role < ApplicationRecord
  has_many :job_posts

  def soft_delete
    update(deleted: true)
  end
end
