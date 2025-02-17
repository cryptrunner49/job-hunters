class Interview < ApplicationRecord
  belongs_to :job_application

  enum mode: { none: 0, in_person: 1, video: 2, phone: 3 }
  enum interview_type: { none: 0, technical: 1, hr: 2, final: 3 }  # Adjust enum values as needed.
end
