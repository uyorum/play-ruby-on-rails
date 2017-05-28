require 'rails_helper'

describe RelationshipsController do
  before :each do
    session[:user_id] = create(:user)
  end

  describe "#create" do
    it "returns javascript" do
      post :create, followed_id: create(:user), format: :js
      expect(response.headers['Content-Type']).to match 'text/javascript'
    end
  end
end
