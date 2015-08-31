require 'sinatra/base'
require 'will_paginate'
require 'will_paginate/active_record'
require 'will_paginate/view_helpers/sinatra'
require "will_paginate-bootstrap"
require 'erb'

module AuditorGeneral
  class Web < Sinatra::Base
    helpers WillPaginate::Sinatra::Helpers

    helpers do
      def paginate(collection)
         options = {
           renderer: BootstrapPagination::Sinatra
         }
        will_paginate collection, options
      end

      def filter(type, query, params)
        params = Rack::Utils.parse_nested_query(params)
        if params[type]
          params[type].push(query)
        else
          params[type] = [query]
        end
        url('/?' + params.to_query)
      end
    end

    set :static, true
    set :root, File.expand_path(File.dirname(__FILE__) + "../../web")
    set :public_folder, proc { "#{root}/assets" }
    set :views, proc { "#{root}/views" }

    get "/" do
      @models = AuditorGeneralLog.all.pluck(:model_type).compact.uniq
      @actions = AuditorGeneralLog.all.pluck(:action).compact.uniq
      @origins = AuditorGeneralLog.all.pluck(:origin).compact.uniq

      result = AuditorGeneralLog.all
      result = result.where(model_type: params[:model]) if params[:model]
      result = result.where(action: params[:action])    if params[:action]
      result = result.where(origin: params[:origin])    if params[:origin]

      @old_params = params.to_query

      @logs = result.order(created_at: :desc).paginate(:page => params[:page], :per_page => params[:limit] || 10)
      erb :auditor_general
    end

    get "/:model/:id" do
      @entry = params[:model].classify.constantize.find(params[:id])
      erb :show
    end
  end
end
