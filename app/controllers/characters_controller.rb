class CharactersController < ApplicationController
  def index
    @characters = Character.all
    json_response(@characters)
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end

end
