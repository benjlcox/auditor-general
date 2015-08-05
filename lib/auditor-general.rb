require "auditor-general/version"
require "auditor-general/model"
require "auditor-general/controller"

module AuditorGeneral
  mattr_accessor :origin

  def self.log(options = {})
    AuditorGeneralLog.create(
      model_type: options[:model_type],
      model_id: options[:id],
      action: options[:action],
      alterations: options[:alterations],
      message: options[:message],
      origin: AuditorGeneral.origin
    )
  end
end
