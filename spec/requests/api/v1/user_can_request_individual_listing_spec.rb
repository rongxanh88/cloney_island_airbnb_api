require "rails_helper"

RSpec.describe "Listing Request", :type => :request do
  it "returns a listing json for that user" do
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
end