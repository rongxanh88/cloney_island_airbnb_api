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
    property_type :house
    bed_type :king
    pet_type :no_pets
    room_type :entire_home
    cancellation_policy :flexible
    status :listed
    user_id 1
  end
end