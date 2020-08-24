module V1
  class LocationsController < ApplicationController
    before_action :set_location, only: %i[show update destroy]

    def index
      serialize_object_with_links(Location, LocationSerializer)
    end

    def create
      @location = Location.create!(location_params)
      json_response(@location, :created)
    end

    def show
      json_response(@location)
    end

    def update
      @location.update(location_params)
      head :no_content
    end

    def destroy
      @location.destroy
      head :no_content
    end

    private

    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.permit(:name, :location_type, :url, :dimension)
    end
  end
end
