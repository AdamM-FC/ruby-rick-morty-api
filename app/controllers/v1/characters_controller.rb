module V1
  require_relative './raw_data_topic_producer'

  class CharactersController < ApplicationController
    before_action :set_character, only: %i[show update destroy]

    def initialize
      @dataTopicProducer = RawDataTopicProducer.new
    end

    def index
      serialize_object_with_links(Character, CharacterSerializer)
    end

    # GET
    def show
      json_response(@character)
    end

    # POST
    def create
      character_params.require([:name, :species, :status, :character_type, :gender, :image])
      @dataTopicProducer.produce(:POST, character_params)
      head :no_content
    end

    # PATCH
    def update
      @dataTopicProducer.produce(:PATCH, character_params)
      head :no_content
    end

    # DELETE
    def destroy
      params.require(:id)
      @dataTopicProducer.produce(:DELETE, params)
      head :no_content
    end

    private

    def character_params
      params.permit(:name, :species, :status, :character_type, :gender, :image, :location_id, :origin_id)
    end

    def set_character
      @character = Character.find(params[:id])
    end
  end
end
