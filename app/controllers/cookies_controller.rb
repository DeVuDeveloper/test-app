class CookiesController < ApplicationController
  include ActionView::RecordIdentifier
  include OvenLoading
  before_action :authenticate_user!
  before_action :load_oven, only: [:new, :create]

  def create
    if @oven.online
      if cookies_already_in_oven?
        oven_already_has_cookies
      else
        create_service = Cookies::CreateService.new(@oven, cookie_params)
        validation_service = Cookies::ValidationService.new(cookie_params)
  
        if validation_service.validate.nil? && create_service.call
          cookies_created_successfully
        else
          @cookie = @oven.cookies.build(cookie_params)
          flash.now[:alert] = validation_service.validate || create_service.error_message
          respond_to do |format|
            format.html { redirect_to ovens_path, alert: flash.now[:alert] }
            format.turbo_stream { flash.now[:alert] = flash.now[:alert] }
          end
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to ovens_path, alert: "Cannot create cookies when the oven is offline." }
        format.turbo_stream { flash.now[:alert] = "Cannot create cookies when the oven is offline." }
      end
    end
  end


  private


  def cookies_already_in_oven?
    @oven.cookies.present?
  end

  def oven_already_has_cookies
    respond_to do |format|
      format.html { redirect_to ovens_path, alert: "Cookies are already in the oven!" }
      format.turbo_stream { flash.now[:alert] = "Cookies are already in the oven!" }
    end
  end

  def cookies_created_successfully
    respond_to do |format|
      format.html { redirect_to ovens_path, notice: "Cookies were successfully created." }
      format.turbo_stream { flash.now[:notice] = "Cookies were successfully created." }
    end
  end

  def cookie_params
    params.require(:cookie).permit(:fillings, :quantity, :storage, :cooking_time, :price)
  end
end
