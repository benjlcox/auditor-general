class User < ActiveRecord::Base
  include AuditorGeneral::Model

  auditable attributes: [:role], create: false
end
