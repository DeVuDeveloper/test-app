class Ovens::CookieInfoComponent < ViewComponent::Base
  def initialize(oven)
    @oven = oven
  end

  def render
    content_tag(:div, class: "cookie-info") do
      render_header +
        render_content
    end
  end

  private

  def render_header
    content_tag(:h4, "Cookie in oven:")
  end

  def render_content
    if @oven.cookies.any?
      render_cookies_info
    else
      render_empty_oven
    end
  end

  def render_cookies_info
    content_tag(:p) do
      "#{@oven.cookies.size} with #{@oven.first_cookie_fillings || "no fillings"}"
    end +
      render_cookie_status
  end

  def render_cookie_status
    if @oven.first_cookie_ready?
      content_tag(:p, class: "text-success") do
        "(Your Cookie is Ready)"
      end +
        button_to("Retrieve Cookies", empty_oven_path(@oven), class: "btn btn-primary btn-sm")
    end
  end

  def render_empty_oven
    content_tag(:p, "None") +
      content_tag(:span, "(Oven is empty)", class: "text-danger")
  end
end
