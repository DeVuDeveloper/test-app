class Cookies::FormComponent < ViewComponent::Base
  include ApplicationHelper

  attr_reader :oven, :cookie

  def initialize(oven:, cookie:)
    @oven = oven
    @cookie = cookie
  end

  private

  def form_group(form, attribute, label_text, input_type)
    form.label(attribute, label_text, class: "control-label col-sm-2") +
      form.input(attribute, as: input_type, input_html: {class: "form-control"})
  end

  def form_actions(form)
    content_tag(:div, class: "form-group") do
      content_tag(:div, class: "col-sm-offset-2 col-sm-10") do
        form.button :submit, "Mix and bake", class: "btn btn-primary"
      end
    end
  end
end
