require 'rails_helper'

describe Relationship do
  it "has valid factory" do
    expect(build(:relationship)).to be_valid
  end

  it "is invalid without follower" do
    expect(build(:relationship, follower: nil)).not_to be_valid
  end

  it "is invalid without followed" do
    expect(build(:relationship, followed: nil)).not_to be_valid
  end
end
