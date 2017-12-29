RSpec.shared_context 'initialize data' do
  let(:test_user) { User.find(RSpec.configuration.test_data[:user]) }
end

RSpec.configure do |config|
  config.add_setting :test_data
  config.test_data = {}

  config.before :suite do
    config.test_data[:user] = FactoryBot.create(:user).id
  end

  config.include_context 'initialize data'

  config.after :suite do
    User.destroy_all
  end
end
