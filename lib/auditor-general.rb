require "auditor-general/version"
require "auditor-general/model"
require "auditor-general/controller"
require "auditor-general/web"
require "app/models/auditor_general_log"

module AuditorGeneral
  mattr_accessor :origin

  def self.log(options = {})
    AuditorGeneralLog.create(
      model_type: options[:model_type],
      model_id: options[:model_id],
      action: options[:action],
      alterations: options[:alterations],
      message: options[:message],
      origin: AuditorGeneral.origin
    )
  end
end
