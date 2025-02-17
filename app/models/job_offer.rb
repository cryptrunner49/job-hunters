class JobOffer < ApplicationRecord
  belongs_to :company
  belongs_to :role

  enum :remote, [ :unknown, :no, :partial, :full ], prefix: true
  enum :english_level, [ :unknown, :basic, :intermediate, :advanced ], prefix: true
  enum :japanese_level, [ :unknown, :n5, :n4, :n3, :n2, :n1, :business_level ], prefix: true
  enum :employment_type, [ :unknown, :full_time, :part_time, :contract, :temporary, :intern ], prefix: true
end
