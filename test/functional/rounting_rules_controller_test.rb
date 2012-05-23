require 'test_helper'

class RountingRulesControllerTest < ActionController::TestCase
  setup do
    @rounting_rule = rounting_rules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rounting_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rounting_rule" do
    assert_difference('RountingRule.count') do
      post :create, rounting_rule: @rounting_rule.attributes
    end

    assert_redirected_to rounting_rule_path(assigns(:rounting_rule))
  end

  test "should show rounting_rule" do
    get :show, id: @rounting_rule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rounting_rule
    assert_response :success
  end

  test "should update rounting_rule" do
    put :update, id: @rounting_rule, rounting_rule: @rounting_rule.attributes
    assert_redirected_to rounting_rule_path(assigns(:rounting_rule))
  end

  test "should destroy rounting_rule" do
    assert_difference('RountingRule.count', -1) do
      delete :destroy, id: @rounting_rule
    end

    assert_redirected_to rounting_rules_path
  end
end
