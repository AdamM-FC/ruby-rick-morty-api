class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  ITEMS_PER_PAGE = 20

  def serialize_object_with_links(object, serializer)
    total_count = object.all.size
    array = object.all.paginate(page: params[:page], per_page: ITEMS_PER_PAGE)
    results = ActiveModelSerializers::SerializableResource.new(
      array,
      each_serializer: serializer
    )
    render json: {
      info: links(total_count),
      results: results
    }
  end

  def send_kafka_data(params)
    RAW_DATA_PRODUCER.produce(:POST, params)
    head :no_content
  end

  def invalid_post_response(errors_array)
    payload = {
      errors: errors_array,
      status: 400
    }
    render json: payload
  end

  private

  def links(count)
    page = params[:page].to_i
    total_pages = count / ITEMS_PER_PAGE
    current_page = page.zero? ? 1 : page
    prev_page = create_url(current_page - 1) if current_page > 1
    next_page = create_url(current_page + 1) if current_page <= total_pages
    {
      count: count,
      pages: total_pages,
      prev: prev_page,
      next: next_page
    }
   end

  def create_url(page)
    "#{HOST}/#{controller_name}/?page=#{page}"
  end
end
