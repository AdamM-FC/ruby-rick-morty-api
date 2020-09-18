module V1
  class CharactersController < ApplicationController
    before_action :set_character, only: %i[show update destroy]

    def index
      serialize_object_with_links(Character, CharacterSerializer)
    end

    def show
      json_response(@character)
    end

    def create
      permitted_params = params.permit(character_params)
      character = Character.create(permitted_params)

      send_kafka_data(permitted_params, :CHARACTER) if character.valid?
      invalid_post_response(character.errors.full_messages) unless character.valid?
    end

    def update
      permitted_params = params.permit(:id, *character_params)
      RAW_DATA_PRODUCER.produce(:PATCH, :CHARACTER, permitted_params)
      head :no_content
    end

    def destroy
      params.require(:id)
      RAW_DATA_PRODUCER.produce(:DELETE, :CHARACTER, params)
      head :no_content
    end

    private

    def character_params
      %i[name species status character_type gender image location_id origin_id]
    end

    def set_character
      @character = Character.find(params[:id])
    end
  end
end
