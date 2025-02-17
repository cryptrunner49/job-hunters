class JobOffer < ApplicationRecord
  belongs_to :company
  belongs_to :role

  enum remote: { none: 0, no: 1, partial: 2, full: 3 }
  enum english_level: { none: 0, basic: 1, intermediate: 2, business_level: 3 }
  enum japanese_level: { none: 0, n5: 1, n4: 2, n3: 3, n2: 4, n1: 5, business_level: 6 }
  enum employment_type: { none: 0, full_time: 1, part_time: 2, contract: 3, temporary: 4, intern: 5 }
end
