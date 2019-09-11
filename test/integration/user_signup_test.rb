require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: {name: "", email: "user@invalid", password: "foo", password_confirmation: "bar"}}
    end
    assert_template "users/new"
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: {user: {name: "Example User 1", email: "user@example.com", password: "password", password_confirmation: "password"}}
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
