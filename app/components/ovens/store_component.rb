class Ovens::StoreComponent < ViewComponent::Base
  def initialize(current_user)
    @current_user = current_user
  end

  private

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
