class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  ITEMS_PER_PAGE = 20

  def serialize_array_with_links(array, serializer, total_count)
    results = ActiveModelSerializers::SerializableResource.new(
      array,
      each_serializer: serializer
    )
    render json: {
      info: links(total_count),
      results: results
    }
  end

  def links(count)
    total_pages = (ITEMS_PER_PAGE > count) ? 1 : count / ITEMS_PER_PAGE
    current_page = params[:page].to_i.zero? ? 1 : params[:page].to_i
    prev_page = current_page > 1 ? create_url(current_page - 1) : nil
    next_page = current_page < total_pages + 1 ? create_url(current_page + 1) : nil

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
