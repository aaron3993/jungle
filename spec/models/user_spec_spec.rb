require 'rails_helper'

RSpec.describe User, type: :model do
  it "should have a password field when registering" do
    @user = User.new
    @user.first_name = "Aaron"
    @user.last_name = "Sham"
    @user.email = "a"
    @user.password = nil
    @user.password_confirmation = "a"
    @user.save
    expect(@user.errors.full_messages).to include("Password can't be blank")
  end
  it "should have a password_confirmation field when registering" do
    @user = User.new
    @user.first_name = "Aaron"
    @user.last_name = "Sham"
    @user.email = "a"
    @user.password = "aaa"
    @user.password_confirmation = nil
    @user.save
    expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
  end
  it "should not be logged in if password and password_confirmation fields don't match" do
    @user = User.new
    @user.first_name = "Aaron"
    @user.last_name = "Sham"
    @user.email = "a"
    @user.password = "aaa"
    @user.password_confirmation = "b"
    @user.save
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end
  it "should be logged in if password and password_confirmation fields match" do
    @user = User.new
    @user.first_name = "Aaron"
    @user.last_name = "Sham"
    @user.email = "a"
    @user.password = "aaa"
    @user.password_confirmation = "aaa"
    @user.save
    expect(@user).to be_valid
  end
  it "should not be able to log in if they use a case insensitive email" do
    @user = User.new
    @user.first_name = "Aaron"
    @user.last_name = "Sham"
    @user.email = "a"
    @user.password = "aaa"
    @user.password_confirmation = "aaa"
    @user.save
    @nonexisting_user = User.find_by_email("A")
    expect(@nonexisting_user).to eq nil
  end
  it "should be able to log in if they use an email with the right casing" do
    @user = User.new
    @user.first_name = "Aaron"
    @user.last_name = "Sham"
    @user.email = "a"
    @user.password = "aaa"
    @user.password_confirmation = "aaa"
    @user.save
    @existing_user = User.find_by_email("a")
    expect(@existing_user).to eq @user
  end
  it "should have an email field when registering" do
    @user = User.new
    @user.first_name = "Aaron"
    @user.last_name = "Sham"
    @user.email = nil
    @user.password = "aaa"
    @user.password_confirmation = "aaa"
    @user.save
    expect(@user.errors.full_messages).to include("Email can't be blank")
  end
  it "should have a first name field when registering" do
    @user = User.new
    @user.first_name = nil
    @user.last_name = "Sham"
    @user.email = "a"
    @user.password = "a"
    @user.password_confirmation = "a"
    @user.save
    expect(@user.errors.full_messages).to include("First name can't be blank")
  end
  it "should have a last name field when registering" do
    @user = User.new
    @user.first_name = "Aaron"
    @user.last_name = nil
    @user.email = "a"
    @user.password = "aaa"
    @user.password_confirmation = "aaa"
    @user.save
    expect(@user.errors.full_messages).to include("Last name can't be blank")
  end
  it "should have a password with at least 3 characters when registering" do
    @user = User.new
    @user.first_name = "Aaron"
    @user.last_name = "Sham"
    @user.email = "a"
    @user.password = "a"
    @user.password_confirmation = "a"
    @user.save
    expect(@user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
  end
end