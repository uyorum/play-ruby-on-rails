require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it "is invalid without name" do
    user = FactoryGirl.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without email" do
    user = FactoryGirl.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with blank email" do
    user = FactoryGirl.build(:user, email: "     ")
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invlaid with too long name" do
    user = FactoryGirl.build(:user, name: "a" * 51)
    user.valid?
    expect(user.errors[:name]).to include("is too long (maximum is 50 characters)")
  end

  it "is invalid with too long email" do
    user = FactoryGirl.build(:user, email: "a" * 244 + "@example.com")
    expect(user).not_to be_valid
  end

  it "is valid with correct format emails" do
    valid_addresses = %w[user@example.com
                         USER@foo.COM
                         A_US-ER@foo.bar.org
                         first.last@foo.jp
                         alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user = FactoryGirl.build(:user, email: valid_address)
      expect(user).to be_valid
    end
  end

  it "is invalid with incorrect format emails" do
    invalid_addresses = %w[user@example,com
                           user_at_foo.org
                           user.name@example.
                           foo@bar_baz.com
                           foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user = FactoryGirl.build(:user, email: invalid_address)
      expect(user).not_to be_valid
    end
  end

  it "is invalid with duplicate email address" do
    user = FactoryGirl.build(:user)
    FactoryGirl.create(:user, email: user.email.upcase)
    expect(user).not_to be_valid
  end

  it "is invalid with blank password" do
    user = FactoryGirl.build(:user, password: " " * 6)
    expect(user).not_to be_valid
  end

  it "is invalid with too short password" do
    user = FactoryGirl.build(:user, password: "a" * 5)
    expect(user).not_to be_valid
  end

  describe "#remember" do
    it "save token in `remember_digest`" do
      user = FactoryGirl.create(:user, remember_digest: nil)
      user.remember
      expect(user.remember_digest).not_to be_nil
    end
  end

  describe "#downcase_email" do
    it "returns email in downcase" do
      user = FactoryGirl.build(:user, email: "USER@EXAMPLE.com")
      expect(user.send(:downcase_email)).to eq("user@example.com")
    end
  end
end
