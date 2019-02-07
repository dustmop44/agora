require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Who Me", email: "yesyou@itcouldntbe.com", password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "valid email addresses should be valid" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-eR@foo.bar.com first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end
  
  test "invalid email addresses should be invalid" do
    invalid_addresses = %w[user@.com user.com user@example user@example. foo@bar_baz.com foo@bar..com foo@bar+baz.com]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    us2 = @user.dup
    us2.email = @user.email.upcase
    @user.save
    assert_not us2.valid?
  end
  
  test "email addresses should be saved as lowercase" do
    mixed_case_email = "FoO@ExamPLE.Bar"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "password should not be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  test "password should have minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
  
  test "should follow and unfollow a user" do
    testerman = users(:testerman)
    testerwoman = users(:testerwoman)
    assert_not testerman.following?(testerwoman)
    testerman.follow(testerwoman)
    assert testerman.following?(testerwoman)
    assert testerwoman.followers.include?(testerman)
    testerman.unfollow(testerwoman)
    assert_not testerman.following?(testerwoman)
  end
  
  test "feed should have the right posts" do
    man = users(:testerman)
    woman = users(:testerwoman)
    testertest = users(:testertest)
    testertest.microposts.each do |post_following|
      assert man.feed.include?(post_following)
    end
    man.microposts.each do |post_self|
      assert man.feed.include?(post_self)
    end
    woman.microposts.each do |post_unfollowed|
      assert_not man.feed.include?(post_unfollowed)
    end
  end
  
end
