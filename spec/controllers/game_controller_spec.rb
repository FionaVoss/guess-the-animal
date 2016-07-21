require 'rails_helper'

RSpec.describe GameController, type: :controller do

  describe "GET #play" do
    it "returns http success" do
      get :play
      expect(response).to have_http_status(:success)
    end
  end

end
