class Ovens::IndexComponent < ViewComponent::Base
  def initialize(ovens)
    @ovens = ovens
  end

  private

  def render_ovens_list
    @ovens.map do |oven|
      content_tag(:li) do
        link_to oven.name, oven
      end
    end.join.html_safe
  end
end
