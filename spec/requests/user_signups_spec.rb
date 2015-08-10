require 'rails_helper'

RSpec.describe "UserSignups", type: :request do
  describe "GET /user_signups" do
    it "works! (now write some real specs)" do
      get user_signups_path
      expect(response).to have_http_status(200)
    end
  end
end
