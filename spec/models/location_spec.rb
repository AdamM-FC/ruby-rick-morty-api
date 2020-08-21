require 'rails_helper'

RSpec.describe Location, type: :model do
  it { should have_many(:residents) }
  it { should have_many(:origin) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:dimension) }
  it { should validate_presence_of(:location_type) }
  it { should validate_presence_of(:url) }
end
