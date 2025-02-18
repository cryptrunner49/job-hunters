class JobApplication < ApplicationRecord
  belongs_to :hunter
  belongs_to :job_post
  belongs_to :resume
  belongs_to :cover_letter
end
