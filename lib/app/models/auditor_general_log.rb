class AuditorGeneralLog < ActiveRecord::Base
  serialize :alterations

  scope :filter_model, -> (model) { where(:model_type => model.split(",")) }
  scope :filter_action, -> (action) { where(:action => action.split(",")) }
  scope :filter_origin, -> (origin) { where(:origin => origin.split(",")) }
  scope :start_date, -> (start) {where(["created_at > ?", start])}
  scope :finish_date, -> (finish) {where(["created_at < ?", finish])}

end
