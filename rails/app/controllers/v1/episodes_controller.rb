module V1
  class EpisodesController < ApplicationController
    before_action :set_episode, only: %i[show update destroy]

    def index
      serialize_object_with_links(Episode, EpisodeSerializer)
    end

    def create
      @episode = Episode.create!(episode_params)
      json_response(@episode, :created)
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
      params.permit(:name, :episode, :air_date, :url)
    end

    def set_episode
      @episode = Episode.find(params[:id])
    end
  end
end
