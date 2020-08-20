require 'rails_helper'

RSpec.describe Episode, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:episode) }
  it { should validate_presence_of(:air_date) }
  it { should validate_presence_of(:url) }

  describe 'Adding characters ' do
    let!(:episode) { build(:episode) }
    let(:episode_id) { episode.id }

    before do
      character = build(:character)
      episode.characters << character
    end

    it 'updates character episodes list with episode' do
      character = episode.characters.first
      character.episodes.any? { |episode| episode.id == episode_id }
    end
  end
end
