require 'rails_helper'

RSpec.describe Listing, type: :model do
  describe 'attributes' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:accomodates) }
    it { should validate_presence_of(:bathrooms) }
    it { should validate_presence_of(:bedrooms) }
    it { should validate_presence_of(:beds) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:property_type) }
    it { should validate_presence_of(:bed_type) }
    it { should validate_presence_of(:room_type) }
    it { should validate_presence_of(:pet_type) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:cancellation_policy) }
    it { should validate_presence_of(:address) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'enumerated attributes' do
    it { should define_enum_for(:property_type) }
    it { should define_enum_for(:bed_type) }
    it { should define_enum_for(:room_type) }
    it { should define_enum_for(:pet_type) }
    it { should define_enum_for(:status) }
    it { should define_enum_for(:cancellation_policy) }
  end
end
