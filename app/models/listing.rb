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

  def self.create_listing_and_submit_job(listing_params)
    listing = Listing.create!(listing_params)
    attributes = listing.attributes.to_json
    CreateListingJob.perform_now(attributes)
  end

  def self.delete_listing_and_submit_job(result, listing_id)
    listing = Listing.find_by(user_id: result.user_id, id: listing_id)
    if listing
      listing.destroy
      ListingCleanupJob.perform_now(listing_id)
      result.status = 202
      result.message = "Listing Destroyed"
    else
      result.status = 400
      result.message = "Listing Not Found"
    end
  end
end
