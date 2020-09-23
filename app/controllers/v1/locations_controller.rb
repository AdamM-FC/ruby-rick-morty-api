module V1
  class LocationsController < ApplicationController
    before_action :set_location, only: %i[show update destroy]

    def index
      serialize_object_with_links(Location, LocationSerializer)
    end

    def show
      json_response(@location)
    end

    def create
      permitted_params = params.permit(location_params)
      location = Location.create(permitted_params)
      save_and_render(location, permitted_params.to_hash)
    end

    def show
      json_response(@location)
    end

    def update
      permitted_params = params.permit(:id, *location_params)
      location = Location.find(params[:id])
      updated_params = location.attributes.merge!(permitted_params.to_hash)
      save_and_render(location, updated_params, location.id)
    end

    def destroy
      params.require(:id)
      location = Location.find(params[:id])
      save_and_render(location, location.attributes, location.id)
    end

    private

    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      %i[name location_type url dimension]
    end
  end
end
