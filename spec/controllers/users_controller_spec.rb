require 'rails_helper'

describe UsersController do
  shared_examples "public access to users" do
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

    describe "#new" do
      before :each do
        get :new
      end

      it "assigns the new user to @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "renders the :new template" do
        expect(response).to render_template :new
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
  end

  shared_examples "show access to users and full to oneself" do
    describe "#index" do
      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "#edit" do
      context "with id of myself" do
        before :each do
          get :edit, id: @log_in_user
        end

        it "renders the :edit template" do
          expect(response).to render_template :edit
        end
      end

      context "with id of other user" do
        before :each do
          get :edit, id: create(:user)
        end

        it "redirects to static_pages#home" do
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "#update" do
      context "with id of myself" do
        context "with valid attributes" do
          before :each do
            @user = @log_in_user
            patch :update, id: @user,
                  user: attributes_for(:user,
                                       name: 'new-name',
                                       admin: !@user.admin)
            @user.reload
          end

          it "localtes the requested @user" do
            expect(assigns(:user)).to eq(@user)
          end

          it "changes @user's attributes" do
            expect(@user.name).to eq('new-name')
          end

          it "does not change @users's admin attributes" do
            expect(@user.admin).to eq(@user.admin)
          end
        end

        context "with invalid attributes" do
          before :each do
            @user = @log_in_user
            patch :update, id: @user,
                  user: attributes_for(:user,
                                       name: nil)
            @user.reload
          end

          it "does not change @user's attributes" do
            expect(@user).to eq(@user)
          end

          it "renders the :edit template" do
            expect(response).to render_template :edit
          end
        end
      end

      context "with id of other user" do
        before :each do
          get :edit, id: create(:user)
        end

        it "redirects to static_pages#home" do
          expect(response).to redirect_to root_path
        end
      end
    end
  end

  describe "administrator access" do
    before :each do
      @log_in_user = create(:admin_user)
      log_in_as(@log_in_user)
    end

    it_behaves_like "public access to users"
    it_behaves_like "show access to users and full to oneself"

    describe "#destroy" do
      before :each do
        @user = create(:user)
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
  end

  describe "user access" do
    before :each do
      @log_in_user = create(:non_admin_user)
      log_in_as(@log_in_user)
    end

    it_behaves_like "public access to users"
    it_behaves_like "show access to users and full to oneself"

    describe "#destroy" do
      before :each do
        @user = create(:user)
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

  describe "guest access" do
    it_behaves_like "public access to users"

    describe "#index" do
      it "redirects to sessions#new" do
        get :index
        expect(response).to redirect_to login_path
      end
    end

    describe "#edit" do
      it "redirects to sessions#new" do
        get :edit, id: create(:user)
        expect(response).to redirect_to login_path
      end
    end

    describe "#update" do
      before :each do
        @user = create(:user)
        patch :update, id: @user,
              user: attributes_for(:user,
                                   name: 'new-name')
        @user.reload
      end

      it "does not change @user's attributes" do
        expect(@user).to eq(@user)
      end

      it "redirects to sessions#new" do
        get :edit, id: create(:user)
        expect(response).to redirect_to login_path
      end
    end

    describe "#destroy" do
      before :each do
        @user = create(:user)
      end

      it "does not remove the user from the database" do
        expect{
          delete :destroy, id: @user
        }.not_to change(User, :count)
      end

      it "redirects to sessions#new" do
        delete :destroy, id: @user
        expect(response).to redirect_to login_path
      end
    end
  end
end
