require 'rails_helper'

RSpec.describe 'Randomized data' do
  it 'prints some random strings' do
    5.times { puts Faker::Name.name }
  end
end
