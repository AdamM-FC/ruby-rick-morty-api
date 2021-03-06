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
      character = Character.new(permitted_params)
      save_and_render(character, permitted_params.to_hash)
    end

    def update
      permitted_params = params.permit(:id, *character_params)
      character = Character.find(params[:id])
      updated_params = character.attributes.merge!(permitted_params.to_hash)
      save_and_render(character, updated_params, character.id)
    end

    def destroy
      params.require(:id)
      character = Character.find(params[:id])
      save_and_render(character, character.attributes, character.id)
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
