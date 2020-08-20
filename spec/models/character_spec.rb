require 'rails_helper'

RSpec.describe Character, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:species) }
  it { should validate_presence_of(:character_type) }
  it { should validate_presence_of(:gender) }
  it { should validate_presence_of(:image) }

  describe 'Adding episodes' do
    let!(:character) { build(:character) }
    let!(:character_id) { character.id }

    before do
      episode = build(:episode)
      character.episodes << episode
    end

    it 'updates episodes character list with character' do
      episode = character.episodes.first
      episode.characters.any? { |character| character.id == character_id }
    end
  end
end
