require 'test_helper'

module AuditorGeneral
  class ModelTest < ActiveSupport::TestCase
    setup do
      @admin = User.first
    end

    test 'Deletions are logged when flag is not set' do
      assert_difference('AuditorGeneralLog.count') do
        @admin.destroy
      end
    end

    test 'Creations are not logged when flag is set' do
      assert_no_difference('AuditorGeneralLog.count') do
        User.create(name: 'test', role: 'user')
      end
    end

    test 'Deletions log last attributes of record' do
      record = @admin
      @admin.destroy
      log = AuditorGeneralLog.last

      assert_equal record.model_name, log.model_type
      assert_equal record.id, log.model_id
      assert_equal 'destroy', log.action
      assert_equal record.attributes, log.alterations
    end

    test "Changes to auditable attribute are logged" do
      assert_difference('AuditorGeneralLog.count') do
        @admin.update_attribute(:role, 'user')
      end
    end

    test "Changes to auditable attribute record alterations" do
      @admin.update_attribute(:role, 'user')
      changes = {"role"=>["admin", "user"]}
      log = AuditorGeneralLog.last

      assert_equal changes, log.alterations
      assert_nil changes['updated_at']
    end

    test "Changes to not auditable attributes are not logged" do
      assert_no_difference('AuditorGeneralLog.count') do
        @admin.update_attribute(:name, 'Test')
      end
    end

  end
end
