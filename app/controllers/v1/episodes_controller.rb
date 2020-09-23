module V1
  class EpisodesController < ApplicationController
    before_action :set_episode, only: %i[show update destroy]

    def index
      serialize_object_with_links(Episode, EpisodeSerializer)
    end

    def show
      json_response(@episode)
    end

    def create
      permitted_params = params.permit(episode_params)
      episode = Episode.create(permitted_params)
      save_and_render(episode, permitted_params.to_hash)
    end

    def update
      permitted_params = params.permit(:id, *episode_params)
      episode = Episode.find(params[:id])
      updated_params = episode.attributes.merge!(permitted_params.to_hash)
      save_and_render(episode, updated_params, episode.id)
    end

    def destroy
      params.require(:id)
      episode = Episode.find(params[:id])
      save_and_render(episode, episode.attributes, episode.id)
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
