require "rails_helper"

RSpec.describe SalesController, type: :controller do
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  it "renders all foods that are not on sales" do
    get :new
    expect(response).to render_template(:new)
  end
end
