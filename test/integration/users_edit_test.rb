require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:testerman)
  end
  
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: {name: "", email: "in@valid", password: "not", password_confirmation: "long" } }
    assert_template 'users/edit'
    assert_select "div#error_explanation", /This form contains 4 errors.+/m
  end
  
  test "successful edit with friendly forwarding only once" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    assert_nil session[:forwarding_url]
    name = "Test Or Man"
    email = "onlytest@have.email"
    patch user_path(@user), params: { user: { name: name, email: email, password: "", password_confirmation: ""} }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
