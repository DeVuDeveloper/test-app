class Ovens::ShowComponent < ViewComponent::Base
  include Turbo::FramesHelper
  def initialize(oven)
    @oven = oven
  end
end