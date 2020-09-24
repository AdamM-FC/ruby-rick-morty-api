require 'rails_helper'

RSpec.describe Episode, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:episode) }
  it { should validate_presence_of(:air_date) }
  it { should validate_presence_of(:url) }

  describe 'Adding characters ' do
    let!(:episode) { build(:episode) }
    let!(:character) { build(:character) }
    let(:episode_id) { episode.id }

    before do
      episode.characters << character
      character.episodes << episode
    end

    it 'updates character episodes list with episode' do
      episode_found = character.episodes.any? { |episode| episode.id == episode_id }
      expect(episode_found).to eq(true)
    end
  end
end
