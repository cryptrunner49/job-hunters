class CoverLetter < ApplicationRecord
  belongs_to :hunter
  has_many :job_applications

  validates :subject, presence: true, uniqueness: true

  def soft_delete
    update(deleted: true)
  end

  def deleted?
    deleted
  end
end
