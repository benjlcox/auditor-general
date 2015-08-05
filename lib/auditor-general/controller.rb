module AuditorGeneral
  module Controller
    extend ActiveSupport::Concern

    included do
      before_filter :log_origin
    end

    def log_origin
      AuditorGeneral.origin = current_user.present? ? current_user.email : self.class.to_s
    end
  end
end
