require 'rails_helper'

RSpec.describe Character, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:species) }
  it { should validate_presence_of(:character_type) }
  it { should validate_presence_of(:gender) }
  it { should validate_presence_of(:image) }
end
