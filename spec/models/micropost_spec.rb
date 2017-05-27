require 'rails_helper'

describe Micropost do
  it "has valid factory" do
    expect(build(:micropost)).to be_valid
  end

  it "is invalid without user" do
    micropost = build(:micropost, user_id: nil)
    expect(micropost).not_to be_valid
  end

  it "is invalid with blank content" do
    micropost = build(:micropost, content: "     ")
    expect(micropost).not_to be_valid
  end

  it "is invalid with too long content" do
    micropost = build(:micropost, content: "a" * 141)
    expect(micropost).not_to be_valid
  end

  describe "#default_scope" do
    it "returns most recent post in first" do
      5.times do
        create(:micropost)
      end
      most_recent = create(:micropost, created_at: Time.zone.now)
      expect(Micropost.first).to eq(most_recent)
    end
  end
end
