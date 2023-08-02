class Cookies::CreateService < ApplicationService
  def initialize(oven, cookie, params)
    @oven = oven
    @params = params
    @cookie = cookie
  end

  def call
    create_cookies
  end

  private

  def create_cookies
    fillings = @params[:fillings]
    num_cookies_to_bake = @params[:quantity].to_i

    if fillings.blank?
      @cookie = @oven.cookies.build(@params)
      @cookie.errors.add(:fillings, "must be present.")
      raise ValidationError, @cookie
    end

    if num_cookies_to_bake <= 0
      @cookie = @oven.cookies.build(@params)
      @cookie.errors.add(:quantity, ": please enter a valid quantity.")
      raise ValidationError, @cookie
    elsif num_cookies_to_bake > 20
      @cookie = @oven.cookies.build(@params)
      @cookie.errors.add(:quantity, ": you can't put more than 20 cookies in the oven.")
      raise ValidationError, @cookie
    end

    num_cookies_to_bake.times do
      cookie = @oven.cookies.build(@params)
      cookie.save
    end
  end

  class ValidationError < StandardError
    attr_reader :cookie

    def initialize(cookie)
      @cookie = cookie
    end
  end
end
