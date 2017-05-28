require 'rails_helper'

describe UsersController do
  before :each do
    allow(controller).to receive(:logged_in_user)
    allow(controller).to receive(:correct_user)
  end

  describe "#index" do
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "#show" do
    before :each do
      @user = create(:user)
      get :show, id: @user
    end

    it "assigns the requested user to @user" do
      expect(assigns(:user)).to eq(@user)
    end

    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end

  describe "#create" do
    context "with valid attributes" do
      it "saves the new user in the database" do
        expect{
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "sets the message in flash[:info]" do
        post :create, user: attributes_for(:user)
        expect(flash[:info]).not_to be_nil
      end

      it "redirects to static_pages#home" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to root_path
      end
    end

    context "with invalid attributes" do
      it "does not save the new user in the database" do
        expect{
          post :create, user: attributes_for(:user, name: nil)
        }.not_to change(User, :count)
      end

      it "renders the :new template" do
        post :create, user: attributes_for(:user, name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe "#edit" do
    before :each do
      @user = create(:user)
      get :edit, id: @user
    end

    it "renders the :edit template" do
      expect(response).to render_template :edit
    end
  end

  describe "#destroy" do
    context "logged in as admin user" do
      before :each do
        @user = create(:user)
        allow(controller).to receive(:current_user).and_return(build(:admin_user))
      end

      it "remove the user from the database" do
        expect{
          delete :destroy, id: @user
        }.to change(User, :count).by(-1)
      end

      it "sets the message in flash[:success]" do
        delete :destroy, id: @user
        expect(flash[:success]).not_to be_nil
      end

      it "redirects to users#index" do
        delete :destroy, id: @user
        expect(response).to redirect_to users_path
      end
    end

    context "logged in as non-admin user" do
      before :each do
        @user = create(:user)
        allow(controller).to receive(:current_user).and_return(build(:non_admin_user))
      end

      it "does not remove the user from the database" do
        expect{
          delete :destroy, id: @user
        }.not_to change(User, :count)
      end

      it "redirects to static_pages#home" do
        delete :destroy, id: @user
        expect(response).to redirect_to root_path
      end
    end
  end
end
