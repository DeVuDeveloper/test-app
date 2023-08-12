class Cookies::CreateService < ApplicationService
  def initialize(oven, params)
    @oven = oven
    @params = params
  end

  def call
    create_cookies
  end

  def total_price
    @total_price
  end

  def change
    @params[:price].to_f - @total_price
  end

  private

  def create_cookies
    num_cookies_to_bake = @params[:quantity].to_i
    cooking_time = @params[:cooking_time].to_i
    price_per_cookie = @params[:price].to_f

    @total_price = num_cookies_to_bake * price_per_cookie

    num_cookies_to_bake.times do
      cookie = @oven.cookies.build(@params)
      cookie.save
      cookie.update(cooked_at: Time.now + cooking_time)
    end
  end

  def error_message
    "Error creating cookies"
  end
end

