require 'sinatra/base'
require 'will_paginate'
require 'will_paginate/active_record'
require 'will_paginate/view_helpers/sinatra'
require "will_paginate-bootstrap"
require 'erb'
require 'csv'

module AuditorGeneral
  class Web < Sinatra::Base
    set :static, true
    set :root, File.expand_path(File.dirname(__FILE__) + "../../web")
    set :public_folder, proc { "#{root}/assets" }
    set :views, proc { "#{root}/views" }

    helpers WillPaginate::Sinatra::Helpers
    helpers do
      def paginate(collection)
         options = {
           renderer: BootstrapPagination::Sinatra
         }
        will_paginate collection, options
      end
    end

    def filter_logs(params)
      result = AuditorGeneralLog.where(nil)
      result = result.filter_model(params[:model])   if params[:model]
      result = result.filter_action(params[:action]) if params[:action]
      result = result.filter_origin(params[:origin]) if params[:origin]
      result = result.start_date(Time.parse(params[:start])) unless params[:start].blank?
      result = result.finish_date(Time.parse(params[:finish])) unless params[:finish].blank?
      result
    end

    get "/" do
      @models = AuditorGeneralLog.all.pluck(:model_type).compact.uniq
      @actions = AuditorGeneralLog.all.pluck(:action).compact.uniq
      @origins = AuditorGeneralLog.all.pluck(:origin).compact.uniq

      result = filter_logs(params)

      @logs = result.order(created_at: :desc).paginate(:page => params[:page], :per_page => params[:limit] || 10)

      erb :auditor_general
    end

    get '/csv' do
      result = params.empty? ? AuditorGeneralLog.all : filter_logs(params)
      content_type 'application/csv'
      attachment "auditor_general_export.csv"
      csv_string = CSV.generate do |csv|
        csv << result.column_names
        result.each do |record|
          csv << record.attributes.values
        end
      end
    end

    get "/:model/:id" do
      @entry = params[:model].classify.constantize.find(params[:id])
      erb :show
    end
  end
end
