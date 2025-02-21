class Current < ActiveSupport::CurrentAttributes
  attribute :session
  delegate :hunter, to: :session, allow_nil: true
end
