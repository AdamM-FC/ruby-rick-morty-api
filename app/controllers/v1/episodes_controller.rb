module V1
  class EpisodesController < ApplicationController
    before_action :set_episode, only: %i[show update destroy]

    def index
      serialize_object_with_links(Episode, EpisodeSerializer)
    end

    def create
      permitted_params = params.permit(episode_params)
      episode = Episode.create(permitted_params)
      
      send_kafka_data(permitted_params) if episode.valid?
      invalid_post_response(episode.errors.full_messages) unless episode.valid?
    end

    def show
      json_response(@episode)
    end

    def update
      @episode.update(episode_params)
      head :no_content
    end

    def destroy
      @episode.destroy
      head :no_content
    end

    private

    def episode_params
      %i[name episode air_date url gender]
    end

    def set_episode
      @episode = Episode.find(params[:id])
    end
  end
end
