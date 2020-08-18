require 'rails_helper'

RSpec.describe 'Episodes API', type: :request do
  let!(:episodes) { create_list(:episode, 10) }
  let(:episode_id) { episodes.first.id }

  # GET
  describe 'Get /episodes' do
    before { get '/episodes' }

    it 'returns episodes' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # POST
  describe 'Post /episodes' do
    context 'when the request is valid' do
      name = 'Episode'
      episode = 'S01E01'
      url = 'www'
      air_date = Time.now

      let(:valid_attributes) do
        { name: name,
          episode: episode,
          url: url,
          air_date: air_date }
      end

      before { post '/episodes', params: valid_attributes }

      it 'creates a episode' do
        expect(json['name']).to eq(name)
        expect(json['episode']).to eq(episode)
        expect(json['url']).to eq(url)
        expect(json['air_date']).to_not be_empty
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before do
        post '/episodes', params: { name: 'name',
                                    episode: 'episode',
                                    url: 'url' }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Air date can't be blank/)
      end
    end
  end

  # PUT
  describe 'Put /episodes/:id' do
    let(:valid_attributes) { { name: 'test' } }

    context 'when the record exists' do
      before { put "/episodes/#{episode_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # DELETE
  describe 'DELETE /episodes/:id' do
    before { delete "/episodes/#{episode_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
