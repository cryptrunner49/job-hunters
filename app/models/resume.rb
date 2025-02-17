class Resume < ApplicationRecord
  belongs_to :hunter

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
end
