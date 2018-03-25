class ApplicationController < ActionController::API

  private

  def page
    @page ||= params[:page] || 1
  end

  def per_page
    @per_page ||= params[:per_page] || 10
  end

  def pagination_meta(object)
    links = []

    links << {}.tap do |hash|
      hash[:href] = page_url(1)
      hash[:rel] = "first"
      hash[:type] = "GET"
    end if !object.first_page? && object.total_count > 0

    links << {}.tap do |hash|
      hash[:href] = page_url(page)
      hash[:rel] = "current"
      hash[:type] = "GET"
    end if object.total_count > 0

    links << {}.tap do |hash|
      hash[:href] = page_url(object.next_page)
      hash[:rel] = "next"
      hash[:type] = "GET"
    end if object.next_page

    links << {}.tap do |hash|
      hash[:href] = page_url(object.prev_page)
      hash[:rel] = "prev"
      hash[:type] = "GET"
    end if object.prev_page

    links << {}.tap do |hash|
      hash[:href] = page_url(object.total_pages)
      hash[:rel] = "last"
      hash[:type] = "GET"
    end if !object.last_page? && object.total_count > 0

    links << {}.tap do |hash|
      hash[:total_count] = object.total_count
    end

    links
  end

  def set_pagination_headers(v_name)
    pc = instance_variable_get("@#{v_name}")

    headers["X-Total-Count"] = pc.total_count
    headers["Link"] = build_links(pc)
  end

  def build_links(pc)
    links = []
    links << page_link(1, "first") if !pc.first_page? && pc.total_count > 0
    links << page_link(pc.prev_page, "prev") if pc.prev_page
    links << page_link(page, "current") if pc.total_count > 0
    links << page_link(pc.next_page, "next") if pc.next_page
    links << page_link(pc.total_pages, "last") if !pc.last_page? && pc.total_count > 0

    links.join(", ") if links.present?
  end

  def page_url(page)
    base_uri = request.url.split("?").first
    "#{base_uri}?#{request.query_parameters.merge(page: page).to_param}"
  end

  def page_link(page, rel)
    base_uri = request.url.split("?").first
    "<#{page_url(page)}>; rel='#{rel}'"
   end
end
