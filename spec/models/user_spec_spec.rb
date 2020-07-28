require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
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
    it "should not be able to register if password and password_confirmation fields don't match" do
      @user = User.new
      @user.first_name = "Aaron"
      @user.last_name = "Sham"
      @user.email = "a"
      @user.password = "aaa"
      @user.password_confirmation = "b"
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "should be able to register if password and password_confirmation fields match" do
      @user = User.new
      @user.first_name = "Aaron"
      @user.last_name = "Sham"
      @user.email = "a"
      @user.password = "aaa"
      @user.password_confirmation = "aaa"
      @user.save
      expect(@user).to be_valid
    end
    it "should not be able to register if a case insensitive email already exists" do
      @user = User.new
      @user.first_name = "Aaron"
      @user.last_name = "Sham"
      @user.email = "a"
      @user.password = "aaa"
      @user.password_confirmation = "aaa"
      @user.save
      @user2 = User.new
      @user2.first_name = "aron"
      @user2.last_name = "ham"
      @user2.email = "A"
      @user2.password = "aaa"
      @user2.password_confirmation = "aaa"
      @user2.save
      # @existing_user = User.find_by_email("A")
      # expect(@existing_user).to eq nil
      expect(@user2).not_to be_valid
    end
    it "should be able to register if they use an email with the right casing" do
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
      puts @user.inspect
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

    describe '.authenticate_with_credentials' do
      it "should log in the user with the right credentials" do
        @user = User.new
        @user.first_name = "Aaron"
        @user.last_name = "Sham"
        @user.email = "a"
        @user.password = "aaa"
        @user.password_confirmation = "aaa"
        @user.save
        expect(User.authenticate_with_credentials("a", "aaa")).to eq(@user)
      end
      it "should not log in the user with the wrong email" do
        @user = User.new
        @user.first_name = "Aaron"
        @user.last_name = "Sham"
        @user.email = "b"
        @user.password = "aaa"
        @user.password_confirmation = "aaa"
        @user.save
        expect(User.authenticate_with_credentials("a", "aaa")).to eq(nil)
      end
      it "should not log in the user with the wrong password" do
        @user = User.new
        @user.first_name = "Aaron"
        @user.last_name = "Sham"
        @user.email = "a"
        @user.password = "aaa"
        @user.password_confirmation = "aab"
        @user.save
        expect(User.authenticate_with_credentials("a", "aaa")).to eq(nil)
      end
      it "should log in the user with trailing spaces on the email" do
        @user = User.new
        @user.first_name = "Aaron"
        @user.last_name = "Sham"
        @user.email = "a"
        @user.password = "aaa"
        @user.password_confirmation = "aaa"
        @user.save
        expect(User.authenticate_with_credentials(" a ", "aaa")).to eq(@user)
      end
      it "should log in the user with different casing for the email" do
        @user = User.new
        @user.first_name = "Aaron"
        @user.last_name = "Sham"
        @user.email = "a"
        @user.password = "aaa"
        @user.password_confirmation = "aaa"
        @user.save
        expect(User.authenticate_with_credentials("A", "aaa")).to eq(@user)
      end
    end
  end
end