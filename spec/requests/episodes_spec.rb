require 'rails_helper'

RSpec.describe 'Episodes API', type: :request do
  let!(:episodes) { create_list(:episode, 50, :with_characters) }
  let(:episode_id) { episodes.first.id }

  # GET
  describe 'Get /episodes' do
    before { get '/episodes' }

    it 'returns episodes' do
      expect(json).not_to be_empty
      expect(json['results'].size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'Get /episodes/?page' do
    before { get '/episodes/?page=2' }

    it 'returns episodes' do
      expect(json).not_to be_empty
      expect(json['results'].size).to eq(20)
    end

    it 'returns pagination information' do 
      page_information = json['info']

      expect(page_information).not_to be_empty
      expect(page_information['count']).to eq(50)
      expect(page_information['pages']).to eq(2)
      expect(page_information['prev']).to eq("#{HOST}/episodes/?page=1")
      expect(page_information['next']).to eq("#{HOST}/episodes/?page=3")
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'Get /episodes/id' do
    before { get "/episodes/#{episode_id}" }

    it 'returns episode with characters' do
      expect(json['characters']).not_to be_empty
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
    name = 'John Doe'
    let(:valid_attributes) { { name: name } }

    context 'when the record exists' do
      before { put "/episodes/#{episode_id}", params: valid_attributes }

      it 'returns empty body' do
        expect(response.body).to be_empty
      end

      it 'updates the record' do
        episode = Episode.find(episode_id)
        expect(episode.name).to eq(name)
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
