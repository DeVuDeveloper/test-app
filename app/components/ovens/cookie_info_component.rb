class Ovens::CookieInfoComponent < ViewComponent::Base
  def initialize(oven:)
    @oven = oven
  end

  def render
    render_header +
      render_content
  end

  private

  def render_header
    content_tag(:h5, "Cookies in oven:", class: "mb-3 text-primary")
  end

  def render_content
    if @oven.cookies.any?
      render_cookies_info
    else
      render_empty_oven
    end
  end

  def render_cookies_info
    content_tag(:p, class: "text-success") do
      "#{pluralize(@oven.cookies.size, 'cookie')} with #{@oven.first_cookie_fillings || "no fillings"}"
    end +
    render_cookie_status
  end

  def render_cookie_status
    content_tag(:div, class: "cookie-status", data: { controller: "cookies", "cookies-oven-id": @oven.id }) do
    content_tag(:div, "", class: "timer text-orange", data: { target: "cookies.timer" }) +
    button_to("Retrieve Cookies", empty_oven_path(@oven), class: "btn btn-primary btn-retrieve hidden", data: { "oven-id": @oven.id, target: "cookies.button" }, method: :post) +
    content_tag(:div, "Cookies are ready!", class: "text-ready text-success hidden", data: { target: "cookies.ready" }) +
    content_tag(:div, class: "loader hidden", data: { target: "cookies.loader" }) do
    content_tag(:i, "", class: "fas fa-spinner fa-spin")
      end
    end
  end
  
  def render_empty_oven
    content_tag(:span, "(Oven is empty)", class: "text-danger")
  end
end

