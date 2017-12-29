require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { test_user }

  1000.times do
    it 'behaves like something' do
      expect {
        user.update_attributes(name: 'New Name')
      }.to change(user, :name)
    end
  end
end
