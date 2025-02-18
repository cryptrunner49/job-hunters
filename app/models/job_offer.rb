class JobOffer < ApplicationRecord
  belongs_to :hunter
  belongs_to :job_post
  belongs_to :company
end
