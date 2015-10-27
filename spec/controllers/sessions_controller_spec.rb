require "rails_helper"
RSpec.describe SessionsController, type: :controller do
  describe "POST #create" do
    context "when password is invalid" do
      it "renders the page with error" do
        user = create(:user)

        post :create, session: { email: user.email, password: "invalid" }

        expect(response).to render_template(:new)
        expect(flash[:danger]).to match("Invalid email/password confirmation")
      end
    end
  end
end
