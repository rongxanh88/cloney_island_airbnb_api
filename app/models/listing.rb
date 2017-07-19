class Listing < ApplicationRecord
  validates :name, :description, :accomodates, :bathrooms, presence: true
  validates :bedrooms, :beds, :price, :property_type, :bed_type, presence: true
  validates :pet_type, :room_type, :status, :user_id, presence: true
  validates :cancellation_policy, :address, presence: true

  validates :name, uniqueness: true

  enum property_type: [:house, :apartment, :guesthouse, :boat, :treehouse]
  enum room_type: [:entire_home, :private_room, :shared_room]
  enum bed_type: [:king, :queen, :double, :twin, :single, :couch]
  enum pet_type: [:no_pets, :cat, :dog, :cat_and_dog, :misc]
  enum status: [:unlisted, :listed]
  enum cancellation_policy: [:flexible, :moderate, :strict]

  after_create :update_main_rails_app
 
  protected
  def update_main_rails_app
    # binding.pry
    listing = Listing.last
    five_min_exp = Time.now.to_i + 300
    payload = {app_auth: ENV['webhook_secret'], exp: five_min_exp}
    jwt = JWT.encode payload, ENV['hmac_secret'], 'HS256'
    auth = {Authorization: 'Bearer ' + jwt}
    connection = Faraday.new(url: 'localhost:3000')

    response = connection.post do |req|
      req.url '/api/v1/integration'
      req.headers['Authorization'] = 'Bearer ' + jwt
      req.body = "#{listing.attributes}"
    end
    binding.pry
    "hello"
  end
end