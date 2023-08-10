class Cookies::FormComponent < ViewComponent::Base
  include ApplicationHelper

  attr_reader :oven, :cookie

  def initialize(oven:, cookie:)
    @oven = oven
    @cookie = cookie
  end
end
