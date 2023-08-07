class Ovens::IndexComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(ovens:)
    @ovens = ovens
  end
end
