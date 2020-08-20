require 'rails_helper'

RSpec.describe 'Characters API', type: :request do
  let!(:characters) { create_list(:character, 10) }
  let(:character_id) { characters.first.id }

  # GET
  describe 'Get /characters' do
    before { get '/characters' }

    it 'returns characters' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # POST
  describe 'Post /characters' do
    context 'when the request is valid' do
      name = 'Rick'
      species = 'Alive'
      status = 'Alive'
      character_type = 'Character'
      gender = 'Male'
      image = 'N/A'

      let(:valid_attributes) do
        { name: name,
          species: species,
          status: status,
          character_type: character_type,
          gender: gender,
          image: image }
      end

      before { post '/characters', params: valid_attributes }

      it 'creates a character' do
        expect(json['name']).to eq(name)
        expect(json['species']).to eq(species)
        expect(json['status']).to eq(status)
        expect(json['character_type']).to eq(character_type)
        expect(json['gender']).to eq(gender)
        expect(json['image']).to eq(image)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before do
        post '/characters', params: { species: 'Alive',
                                      status: 'Human',
                                      character_type: 'Character',
                                      gender: 'Male',
                                      image: 'N/A' }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # PUT
  describe 'Put /characters/:id' do
    name = 'John Doe'

    let(:valid_attributes) { { name: name } }

    context 'when the record exists' do
      before { put "/characters/#{character_id}", params: valid_attributes }

      it 'returns empty body' do
        expect(response.body).to be_empty
      end

      it 'updates the record' do
        character = Character.find(character_id)
        expect(character.name).to eq(name)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # DELETE
  describe 'DELETE /characters/:id' do
    before { delete "/characters/#{character_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
