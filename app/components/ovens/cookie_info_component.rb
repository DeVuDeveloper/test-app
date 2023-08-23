class Ovens::CookieInfoComponent < ViewComponent::Base
  include Turbo::FramesHelper
  def initialize(oven:)
    @oven = oven
  end
end
