require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'creates successfully when all the required fields are filled, the passwords match and password length is as expected' do
      @user = User.create(
        first_name: "Amanda",
        last_name: "Arnaut",
        email: "example@domain.com",
        password: '1234test',
        password_confirmation: '1234test'
      )
      expect(User.all).to include(@user)
    end

    it 'returns an error when password is empty' do
      @user = User.create(
        first_name: "Amanda",
        last_name: "Arnaut",
        email: "example@domain.com",
        password: nil,
        password_confirmation: '1234test'
      )
       expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'returns an error when password_confirmation is empty' do
      @user = User.create(
        first_name: "Amanda",
        last_name: "Arnaut",
        email: "example@domain.com",
        password: '1234test',
        password_confirmation: nil
      )
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'returns an error when email is empty' do
      @user = User.create(
        first_name: "Amanda",
        last_name: "Arnaut",
        email: nil,
        password: "1234test",
        password_confirmation: "1234test"
      )
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'returns an error when first_name is empty' do
      @user = User.create(
        first_name: nil,
        last_name: "Arnaut",
        email: "example@domain.com",
        password: "1234test",
        password_confirmation: "1234test"
      )
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'returns an error when last_name is empty' do
      @user = User.create(
        first_name: "Amanda",
        last_name: nil,
        email: "example@domain.com",
        password: "1234test",
        password_confirmation: "1234test"
      )
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'returns an error when password and password_confirmation do not match' do
      @user = User.create(password: 'test12', password_confirmation: 'test123')
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'returns an error when the email is already registered (not case sensitive)' do
      @user1 = User.create(
        first_name: "Amanda",
        last_name: "Arnaut",
        email: "EXAMPLE@DOMAIN.com",
        password: "1234test",
        password_confirmation: "1234test"
      )
      @user2 = User.create(
        first_name: "Amanda",
        last_name: "Arnaut",
        email: "example@domain.COM",
        password: "1234test",
        password_confirmation: "1234test"
      )
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it "returns an error when the password's length is less than 7" do
      @user = User.create(password: '2test', password_confirmation: '2test')
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 7 characters)")
    end
  end


  describe '.authenticate_with_credentials' do
    it "should authenticate a visitor if credentials match an user information" do
      @user = User.create(
        first_name: "Amanda",
        last_name: "Arnaut",
        email: "example@domain.com",
        password: "1234test",
        password_confirmation: "1234test"
      )
      user = User.authenticate_with_credentials("example@domain.com","1234test")
      expect(user).to eq(@user)
    end

    it "should return nil if visitor credentials do not match an user information" do
      @user = User.create(
        first_name: "Amanda",
        last_name: "Arnaut",
        email: "example@domain.com",
        password: "1234test",
        password_confirmation: "1234test"
      )
      user = User.authenticate_with_credentials("example@domain.com","test")
      expect(user).to be nil
      user2 = User.authenticate_with_credentials("example@domain","1234test")
      expect(user2).to be nil
    end
    it "should authenticate if visitor types in a few spaces before and/or after the email address" do
      @user = User.create(
        first_name: "Amanda",
        last_name: "Arnaut",
        email: "example@domain.com",
        password: "1234test",
        password_confirmation: "1234test"
      )
      user = User.authenticate_with_credentials(" example@domain.com ","1234test")
      expect(user).to eq(@user)
    end

    it "should authenticate if visitor types in the wrong case for email address" do
      @user = User.create(
        first_name: "Amanda",
        last_name: "Arnaut",
        email: "eXample@domain.COM",
        password: "1234test",
        password_confirmation: "1234test"
      )
      user = User.authenticate_with_credentials("EXAMPLe@DOMAIN.CoM","1234test")
      expect(user).to eq(@user)
    end
    
  end

end
    # examples for this class method here