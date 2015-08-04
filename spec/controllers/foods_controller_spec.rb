require 'rails_helper'

RSpec.describe FoodsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "create a new food item" do

    end

    it "returns to the 'add food' page with errorif no category is selected" do

    end
  end

  describe "PATCH #update" do
    it "updates a selected food with the info provided" do

    end

    it "gives an error if no food is selected" do

    end
  end

  describe "DELETE #destroy" do
    it "deletes food with the selected id from the database" do

    end

    it "redirects to the foods page if no id is selected" do

    end
  end
end
