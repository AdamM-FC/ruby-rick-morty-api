require 'rails_helper'

RSpec.describe Episode, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:episode) }
  it { should validate_presence_of(:air_date) }
  it { should validate_presence_of(:url) }
end
