class JobApplication < ApplicationRecord
  belongs_to :hunter
  belongs_to :job_post
  belongs_to :resume
  belongs_to :cover_letter
  has_many :interviews, dependent: :destroy

  def soft_delete
    update(deleted: true)
  end
end
