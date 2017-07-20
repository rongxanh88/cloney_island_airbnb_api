require "rails_helper"

RSpec.describe "Listing Create Request", :type => :request do
  it "returns a 201 status code for successful resource creation" do
    attributes = attributes_for(:listing)
    one_day_exp = Time.now.to_i + 86400
    payload = {user_id: 1, exp: one_day_exp}
    jwt = JWT.encode payload, ENV['hmac_secret'], 'HS256'
    auth = {Authorization: 'Bearer ' + jwt}
    allow(CreateListingJob).to receive(:perform_now).and_return(true)

    post "/api/v1/listings.json", params: {listing: attributes}, headers: auth
    result = JSON.parse(response.body, symbolize_names: true)
    expect(result[:status]).to eq(201)
    expect(result[:message]).to eq("Listing Created")
  end

  it "returns a 400 status when not including a authorization header" do
    attributes = attributes_for(:listing)

    post "/api/v1/listings.json", params: {listing: attributes}
    result = JSON.parse(response.body, symbolize_names: true)
    expect(result[:status]).to eq(400)
    expect(result[:message]).to eq("Authorization header not set.")
  end

  it "returns a 401 status when the token is expired" do
    attributes = attributes_for(:listing)
    one_day_exp = Time.now.to_i - 1
    payload = {user_id: 1, exp: one_day_exp}
    jwt = JWT.encode payload, ENV['hmac_secret'], 'HS256'
    auth = {Authorization: 'Bearer ' + jwt}

    post "/api/v1/listings.json", params: {listing: attributes}, headers: auth
    result = JSON.parse(response.body, symbolize_names: true)
    expect(result[:status]).to eq(401)
    expect(result[:message]).to eq("Access Token Expired.")
  end
end