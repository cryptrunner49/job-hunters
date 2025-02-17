class Resume < ApplicationRecord
  belongs_to :hunter

  enum resume_type: { none: 0, developer: 1, designer: 2, manager: 3, analyst: 4 }
end
