class StoreComponent < ViewComponent::Base
  def initialize(current_user)
    @current_user = current_user
  end

  private

  def render_bakery_nav
    content_tag(:div, class: "bakery-nav") do
      link_to "View your ovens", ovens_path
    end
  end

  def render_cookies_for_sale
    cookies_for_sale = @current_user.stored_cookies.group_by(&:fillings)

    if cookies_for_sale.any?
      cookies_for_sale.map do |fillings, cookies|
        content_tag(:li) do
          "#{pluralize(cookies.count, "Cookie")} with #{fillings || "no filling"}"
        end
      end.join.html_safe
    else
      content_tag(:li, "No cookies for sale")
    end
  end
end

