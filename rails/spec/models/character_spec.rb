require 'rails_helper'

RSpec.describe Character, type: :model do
  it { should belong_to(:location) }
  it { should belong_to(:origin) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:species) }
  it { should validate_presence_of(:character_type) }
  it { should validate_presence_of(:gender) }
  it { should validate_presence_of(:image) }

  describe 'Adding episodes' do
    let!(:character) { build(:character) }
    let!(:episode) { build(:episode) }
    let!(:character_id) { character.id }

    before do
      character.episodes << episode
      episode.characters << character
    end

    it 'updates episodes character list with character' do
      character_found = episode.characters.any? { |character| character.id == character_id }
      expect(character_found).to eq(true)
    end
  end
end
