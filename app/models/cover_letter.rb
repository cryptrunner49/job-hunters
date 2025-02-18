class CoverLetter < ApplicationRecord
  belongs_to :hunter
  has_many :job_applications

  def soft_delete
    update(deleted: true)
  end
end
