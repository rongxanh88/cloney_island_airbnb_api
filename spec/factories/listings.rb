FactoryGirl.define do
  factory :listing do
    sequence(:name) do  |i|
      "Best Place on Earth #{i}"
    end
    description 'Place new description here'
    address '123 Billygoat Rd. Evergreen, CO 80411'
    accomodates 3
    bathrooms 3
    bedrooms 2
    beds 6
    price 25.99
    house_rules 'No smoking'
    property_type 0
    bed_type 0
    pet_type 0
    room_type 0
    cancellation_policy 0
    status 0
    user_id 1
  end
end