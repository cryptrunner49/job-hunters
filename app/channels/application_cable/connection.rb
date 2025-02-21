module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_hunter

    def connect
      set_current_hunter || reject_unauthorized_connection
    end

    private
      def set_current_hunter
        if session = Session.find_by(id: cookies.signed[:session_id])
          self.current_hunter = session.hunter
        end
      end
  end
end
