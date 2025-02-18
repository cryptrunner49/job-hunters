class JobOffer < ApplicationRecord
  belongs_to :hunter
  belongs_to :job_post
  belongs_to :company

  def soft_delete
    update(deleted: true)
  end
end
