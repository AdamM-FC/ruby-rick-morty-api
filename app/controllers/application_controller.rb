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
