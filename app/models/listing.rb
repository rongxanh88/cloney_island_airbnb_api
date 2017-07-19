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
end
