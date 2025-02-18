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

  def soft_delete
    update(deleted: true)
  end
end
