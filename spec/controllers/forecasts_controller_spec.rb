# spec/controllers/forecasts_controller_spec.rb
require 'rails_helper'

RSpec.describe ForecastsController, type: :controller do
  describe "GET #index" do
    context "with valid address" do
      let(:valid_zip) { "78613" }
      let (:valid_city) { "Cedar Park" }

      it "returns http success" do
        get :index, params: { zip: valid_zip, city: valid_city }
        expect(response).to have_http_status(:success)
      end

      it "assigns @forecast" do
        get :index, params: { zip: valid_zip, city: valid_city }
        expect(assigns(:forecast)).to be_present
      end

      it "assigns @cached" do
        get :index, params: { zip: valid_zip, city: valid_city }
        get :index, params: { zip: valid_zip, city: valid_city }
        expect(assigns(:cached)).to be_present
      end

      it "caches the forecast data" do
        expect {
          get :index, params: { zip: valid_zip, city: valid_city }
        }.to change {Forecast.count }.by(1)
      end
    end

    context "with invalid city" do
      let(:invalid_city) { "Invalid City" }
      let(:valid_zip) { "78613" }

      it "does not assign @forecast" do
        get :index, params: { zip: valid_zip, city: invalid_city }
        expect(assigns(:forecast)).to be_nil
      end
    end
  end
end
