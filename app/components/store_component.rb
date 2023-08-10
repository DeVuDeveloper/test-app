class StoreComponent < ViewComponent::Base
  def initialize(current_user)
    @current_user = current_user
  end

  private

  def render_bakery_nav
    content_tag(:div, class: "text-center mb-6") do
      link_to "View your ovens", ovens_path, class: "inline-block px-4 py-2 bg-blue-700 hover:bg-blue-600 text-blue-100 font-semibold rounded transition duration-300 ease-in-out"
    end
  end

  def render_cookies_for_sale
    cookies_for_sale = @current_user.stored_cookies.group_by(&:fillings)

    if cookies_for_sale.any?
      cookies_for_sale.map do |fillings, cookies|
        content_tag(:li, class: "mb-2 text-blue-300") do
          "#{pluralize(cookies.count, "Cookie")} with #{fillings || "no filling"}"
        end
      end.join.html_safe
    else
      content_tag(:li, "No cookies for sale", class: "mb-2 text-gray-800")
    end
  end
end
