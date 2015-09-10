require 'test_helper'

module AuditorGeneral
  class AuditorGeneralLogTest < ActiveSupport::TestCase

    test '#filter_model only returns records from the passed model' do
      AuditorGeneralLog.filter_model('User').map { |e| assert_equal 'User', e.model_type  }
    end

    test '#filter_action only returns records from the passed action' do
      AuditorGeneralLog.filter_action('update').map { |e| assert_equal 'update', e.action  }
    end

    test '#filter_origin only returns records from the passed origin' do
      AuditorGeneralLog.filter_origin('admin1@example.com').map { |e| assert_equal 'admin1@example.com', e.origin  }
    end

    test '#start_date only returns records from after the passed start_date' do
      AuditorGeneralLog.start_date('2015-12-31').map { |e| assert e.created_at > Time.parse('2015-12-31') }
    end

    test '#finish_date only returns records from before the passed finish_date' do
      AuditorGeneralLog.finish_date('2015-12-31').map { |e| assert e.created_at < Time.parse('2015-12-31') }
    end

    test '#alterations is a serialized attribtue' do
      assert auditor_general_logs(:update_alteration).alterations.is_a?(Hash)
    end
    
  end
end
