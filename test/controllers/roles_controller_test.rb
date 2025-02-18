require "test_helper"

class RolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @role = roles(:one)
    @hunter = hunters(:one)
    sign_in_as(@hunter, "password")
  end

  test "should get index" do
    get roles_url
    assert_response :success
  end

  test "should get new" do
    get new_role_url
    assert_response :success
  end

  test "should create role" do
    assert_difference("Role.count") do
      post roles_url, params: { role: { description: @role.description, name: @role.name } }
    end

    assert_redirected_to role_url(Role.last)
  end

  test "should show role" do
    get role_url(@role)
    assert_response :success
  end

  test "should get edit" do
    get edit_role_url(@role)
    assert_response :success
  end

  test "should update role" do
    patch role_url(@role), params: { role: { description: @role.description, name: @role.name } }
    assert_redirected_to role_url(@role)
  end

  test "should destroy role" do
    assert_no_difference("Role.count") do
      delete role_url(@role)
    end

    @role.reload
    assert @role.deleted
    assert_redirected_to roles_url
  end

  private

  def sign_in_as(hunter, password)
    post session_url, params: { email_address: hunter.email_address, password: password }
  end
end
