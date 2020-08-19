class CharactersController < ApplicationController
  before_action :set_character, only: %i[show update destroy]

  def index
    @characters = Character.all
    render json: @characters.as_json
  end

  def create
    @character = Character.create!(character_params)
    json_response(@character, :created)
  end

  def show
    render json: @character.as_json
  end

  def update
    @character.update(character_params)
    head :no_content
  end

  def destroy
    @character.destroy
    head :no_content
  end

  private

  def character_params
    params.permit(:name, :species, :status, :character_type, :gender, :image)
  end

  def set_character
    @character = Character.find(params[:id])
  end
end
