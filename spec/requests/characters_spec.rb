require 'rails_helper'

RSpec.describe 'Characters API', type: :request do
let!(:characters) { create_list(:character, 10) }
let(:character_id) { characters.first.id }

    describe 'Get /characters' do 
        before { get '/characters'}

        it 'returns characters' do 
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end
    end
end