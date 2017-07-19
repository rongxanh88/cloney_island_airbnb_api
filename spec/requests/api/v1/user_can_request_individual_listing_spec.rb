require "rails_helper"

RSpec.describe "Listing Request", :type => :request do
  it "returns a listing json for that user" do
    skip
    listing = create(:listing, user_id: 56)
    one_day_exp = Time.now.to_i + 86400
    payload = {user_id: listing.user_id, exp: one_day_exp}
    jwt = JWT.encode payload, ENV['hmac_secret'], 'HS256'
    auth = {Authorization: 'Bearer ' + jwt}
    get "/api/v1/listings/#{listing.id}.json", params:nil, headers: auth
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(result[:id]).to eq(listing.id)
    expect(result[:name]).to eq(listing.name)
  end

  it "returns a 400 status when not including a authorization header" do
    skip
    listing = create(:listing, user_id: 99)

    get "/api/v1/listings/#{listing.id}.json"
    result = JSON.parse(response.body, symbolize_names: true)
    
    expect(result[:status]).to eq(400)
    expect(result[:message]).to eq("Authorization header not set.")
  end

  it "returns a 401 status when the token is expired" do
    skip
    listing = create(:listing, user_id: 1)
    expires_a_minute_ago = Time.now.to_i - 60
    payload = {user_id: listing.user_id, exp: expires_a_minute_ago}
    jwt = JWT.encode payload, ENV['hmac_secret'], 'HS256'
    auth = {Authorization: 'Bearer ' + jwt}

    get "/api/v1/listings/#{listing.id}.json", params:nil, headers: auth
    result = JSON.parse(response.body, symbolize_names: true)
    
    expect(result[:status]).to eq(401)
    expect(result[:message]).to eq("Access Token Expired.")
  end
end