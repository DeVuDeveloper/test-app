class Cookies::FormComponent < ViewComponent::Base
  include ApplicationHelper
  def initialize(oven, cookie)
    @oven = oven
    @cookie = cookie
  end
end
