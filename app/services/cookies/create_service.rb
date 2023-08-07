class Cookies::CreateService < ApplicationService
  def initialize(oven, params)
    @oven = oven
    @params = params
  end

  def call
    validate_and_create_cookies
  end

  private

  def validate_and_create_cookies
    validate_params
    create_cookies
  end

  def validate_params
    fillings = @params[:fillings]
    num_cookies_to_bake = @params[:quantity].to_i
    cooking_time = @params[:cooking_time].to_i
  
    raise Cookies::CreateService::ValidationError, build_cookie_with_error("fillings", "must be present.") if fillings.blank?
    raise Cookies::CreateService::ValidationError, build_cookie_with_error("quantity", ": please enter a valid quantity.") if num_cookies_to_bake <= 0 || num_cookies_to_bake > 20
    raise Cookies::CreateService::ValidationError, build_cookie_with_error("cooking_time", ": please enter a valid cooking time.") if cooking_time <= 15
  end
  
  def create_cookies
    num_cookies_to_bake = @params[:quantity].to_i
    cooking_time = @params[:cooking_time].to_i

    num_cookies_to_bake.times do
      cookie = @oven.cookies.build(@params)
      cookie.save
      cookie.update(cooked_at: Time.now + cooking_time)
    end
  end

  def build_cookie_with_error(attribute, message)
    cookie = @oven.cookies.build(@params)
    cookie.errors.add(attribute, message)
    raise Cookies::CreateService::ValidationError.new(cookie)
  end
  
  class ValidationError < StandardError
    attr_reader :cookie

    def initialize(cookie)
      @cookie = cookie
    end
  end
end
