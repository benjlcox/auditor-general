require 'test_helper'

module AuditorGeneral
  class ControllerTest < ActionController::TestCase
    setup do
      @controller = UserController.new
      @admin = User.first
    end

    test "Class name is logged when current_user is not present" do
      @controller.stubs(:current_user).returns(nil)

      get :index

      @admin.update_attribute(:role, 'user')
      log = AuditorGeneralLog.last
      assert_equal 'UserController', log.origin
    end

    test "current_user's email is logged when current_user is present" do
      get :index

      @admin.update_attribute(:role, 'user')
      log = AuditorGeneralLog.last
      assert_equal @controller.current_user.email, log.origin
    end

  end
end
