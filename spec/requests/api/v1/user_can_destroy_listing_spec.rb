require "rails_helper"

RSpec.describe "Listing Destroy Request", :type => :request do
  it "returns a 202 status code for accepted resource delete" do
    listing = create(:listing, user_id: 50)
    one_day_exp = Time.now.to_i + 86400
    payload = {user_id: 50, exp: one_day_exp}
    jwt = JWT.encode payload, ENV['hmac_secret'], 'HS256'
    auth = {Authorization: 'Bearer ' + jwt}

    delete "/api/v1/listings/#{listing.id}", params: nil, headers: auth
    result = JSON.parse(response.body, symbolize_names: true)
    expect(result[:status]).to eq(202)
    expect(result[:message]).to eq("Listing Destroyed")
  end

  it "returns a 400 status when not including a authorization header" do
    listing = create(:listing, user_id: 50)

    delete "/api/v1/listings/#{listing.id}"
    result = JSON.parse(response.body, symbolize_names: true)
    expect(result[:status]).to eq(400)
    expect(result[:message]).to eq("Authorization header not set.")
  end

  it "returns a 401 status when the token is expired" do
    listing = create(:listing, user_id: 50)
    one_day_exp = Time.now.to_i - 1
    payload = {user_id: 50, exp: one_day_exp}
    jwt = JWT.encode payload, ENV['hmac_secret'], 'HS256'
    auth = {Authorization: 'Bearer ' + jwt}

    delete "/api/v1/listings/#{listing.id}", params: nil, headers: auth
    result = JSON.parse(response.body, symbolize_names: true)
    expect(result[:status]).to eq(401)
    expect(result[:message]).to eq("Access Token Expired.")
  end
end