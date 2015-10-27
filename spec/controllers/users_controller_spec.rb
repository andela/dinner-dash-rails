require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    it "should redirect a valid user to users path" do
      @user = create(:user)
      get :show, id: @user
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
    it "should redirect an invalid user to root path" do
      get :show, id: 500
      expect(flash[:message]).to match("We're sorry we couldn't"\
                                      " find any information for this user.")
      expect(response).not_to render_template(:show)
    end
  end
  describe "PUT #update" do
    it "should render edit on unsuccessful update" do
      @user = create(:user)
      put :update, id: @user, user: attributes_for(:another_user)
      expect(response).to render_template(:edit)
    end
  end
end
