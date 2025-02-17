class Interview < ApplicationRecord
  belongs_to :job_application

  enum :mode, [ :in_person, :video, :phone ], prefix: true
  enum :interview_type, [ :technical, :hr, :final ], prefix: true # Adjust enum values as needed.
end
