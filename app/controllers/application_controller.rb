class ApplicationController < ActionController::API

  private

  def page
    @page ||= params[:page] || 1
  end

  def per_page
    @per_page ||= params[:per_page] || 10
  end

  def set_pagination_headers(v_name)
    pc = instance_variable_get("@#{v_name}")

    headers["X-Total-Count"] = pc.total_count

    links = []
    links << page_link(1, "first") if !pc.first_page? && pc.total_count > 0
    links << page_link(pc.prev_page, "prev") if pc.prev_page
    links << page_link(page, "current") if pc.total_count > 0
    links << page_link(pc.next_page, "next") if pc.next_page
    links << page_link(pc.total_pages, "last") if !pc.last_page? && pc.total_count > 0
    headers["Link"] = links.join(", ") if links.present?
  end

  def page_link(page, rel)
    base_uri = request.url.split("?").first
    "<#{base_uri}?#{request.query_parameters.merge(page: page).to_param}>; rel='#{rel}'"
   end
end
