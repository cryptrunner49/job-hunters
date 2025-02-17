class JobApplication < ApplicationRecord
  belongs_to :hunter
  belongs_to :job_offer
  belongs_to :resume
  belongs_to :cover_letter
end
