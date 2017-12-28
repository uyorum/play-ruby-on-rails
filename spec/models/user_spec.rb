require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.create(:user) }

  it "can be destroyed" do
    expect {
      user.destroy
    }.to change(User, :count).by(-1)
  end
end
