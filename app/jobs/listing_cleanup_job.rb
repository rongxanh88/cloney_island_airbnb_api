class ListingCleanupJob < ApplicationJob
  queue_as :urgent

  def perform(listing_id)
    $redis.set("del_listing", listing_id)
  end
end
