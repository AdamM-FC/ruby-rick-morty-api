require 'rails_helper'

RSpec.describe 'Locations API', type: :request do
  let!(:locations) do
    locations = create_list(:location, 10, :with_residents)
  end
  let(:location_id) { locations.first.id }

  # GET
  describe 'Get /locations' do
    before { get '/locations' }

    it 'returns locations' do
      expect(json).not_to be_empty
      expect(json.size).to eq(30)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'Get /locations/id' do
    before { get "/locations/#{location_id}" }

    it 'returns location with residents' do
      expect(json['residents']).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # POST
  describe 'Post /locations' do
    context 'when the request is valid' do
      name = 'Earth'
      location_type = 'Planet'
      dimension = 'Other dimension'
      url = 'www'

      let(:valid_attributes) do
        { name: name,
          location_type: location_type,
          dimension: dimension,
          url: url }
      end

      before { post '/locations', params: valid_attributes }

      it 'creates a location' do
        expect(json['name']).to eq(name)
        expect(json['location_type']).to eq(location_type)
        expect(json['dimension']).to eq(dimension)
        expect(json['url']).to eq(url)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before do
        post '/locations', params: { location_type: 'Alive',
                                      dimension: 'Human',
                                      url: 'Character'}
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
  describe 'Put /locations/:id' do
    name = 'Other planet'

    let(:valid_attributes) { { name: name } }

    context 'when the record exists' do
      before { put "/locations/#{location_id}", params: valid_attributes }

      it 'returns empty body' do
        expect(response.body).to be_empty
      end

      it 'updates the record' do
        location = Location.find(location_id)
        expect(location.name).to eq(name)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # # DELETE
  describe 'DELETE /locations/:id' do
    before { delete "/locations/#{location_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
