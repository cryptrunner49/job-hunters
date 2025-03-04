class JobOffer < ApplicationRecord
  belongs_to :job_application

  def soft_delete
    update(deleted: true)
  end
end
