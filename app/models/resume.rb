class Resume < ApplicationRecord
  belongs_to :hunter
  has_many :job_applications

  enum :resume_type, [
    :backend,
    :frontend,
    :fullstack,
    :software_engineer,
    :ai,
    :data_science,
    :designer,
    :manager,
    :ux
  ], prefix: true

  validates :title, presence: true, uniqueness: true

  def soft_delete
    update(deleted: true)
  end

  def deleted?
    deleted
  end
end
