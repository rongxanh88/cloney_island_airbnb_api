require "rails_helper"

RSpec.describe "Listing Request", :type => :request do
  it "returns a listing json for that user" do
    listing = create(:listing, user_id: 56)
    payload = {user_id: listing.user_id}
    jwt = JWT.encode payload, ENV['hmac_secret'], 'HS256'
    auth = {Authorization: 'Bearer ' + jwt}

    get "/api/v1/listings/#{listing.id}", params:nil, headers: auth

    expect(response).to have_http_status(200)
    # token = SecureRandom.uuid.gsub(/\-/,'')
    # user = create(:user, api_token: token)
    # authorization = {authorization: token}

    # get '/api/v1/access_token.json', params: nil, headers: authorization
    # result = JSON.parse(response.body, symbolize_names: true)
    # decoded_token = JWT.decode(
    #   result[:access_token], ENV['hmac_secret'], true, { algorithm: 'HS256' }
    # )

    # expect(response).to have_http_status(200)
    # expect(decoded_token.first["user_id"]).to eq(user.id)
  end
end