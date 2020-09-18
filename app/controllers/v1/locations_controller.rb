module V1
  class LocationsController < ApplicationController
    before_action :set_location, only: %i[show update destroy]

    def index
      serialize_object_with_links(Location, LocationSerializer)
    end

    def create
      permitted_params = params.permit(location_params)
      location = Location.create(permitted_params)

      send_kafka_data(permitted_params) if location.valid?
      invalid_post_response(location.errors.full_messages) unless location.valid?
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
      %i[name location_type url dimension]
    end
  end
end
