class CreateListingJob < ApplicationJob
  queue_as :urgent

  def perform(listing_attrs)
    $redis.set("listing", listing_attrs)
  end
end
