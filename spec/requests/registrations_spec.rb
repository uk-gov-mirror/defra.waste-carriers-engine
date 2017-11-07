require "rails_helper"

RSpec.describe "Registrations", type: :request do
  describe "GET /registrations" do
    it "returns a success response" do
      get registrations_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /registrations/new" do
    it "returns a success response" do
      get new_registration_path
      expect(response).to have_http_status(200)
    end
  end
end
