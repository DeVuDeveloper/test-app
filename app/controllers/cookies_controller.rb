class CookiesController < ApplicationController
  include OvenLoading

  rescue_from Cookies::CreateService::ValidationError, with: :render_form_with_errors
  before_action :authenticate_user!
  before_action :load_oven, only: [:new, :create]

  def new
    if @oven.cookies.any?
      respond_to do |format|
        format.html { redirect_to @oven, alert: "Cookies are already in the oven!" }
        format.turbo_stream { flash.now[:alert] = "Cookies are already in oven" }
      end
    else
      @cookie = @oven.cookies.build
    end
  end

  def create
    create_service = Cookies::CreateService.new(@oven, cookie_params)
    if create_service.call
      cookies_created_successfully
    else
      @cookie = create_service.cookie
      render :new, status: :unprocessable_entity
    end
  end

  private

  def render_form_with_errors(exception)
    @cookie = exception.cookie
    @ovens = current_user.ovens
    render "ovens/index", status: :unprocessable_entity
  end

  def oven_already_has_cookies
    respond_to do |format|
      format.html { redirect_to @oven, alert: "Cookies are already in the oven!" }
      format.turbo_stream { flash.now[:alert] = "Cookies are already in the oven!" }
    end
  end

  def cookies_created_successfully
    respond_to do |format|
      format.html { redirect_to oven_path(@oven), notice: "Cookies were successfully created." }
      format.turbo_stream { flash.now[:notice] = "Cookies were successfully created." }
    end
  end

  def cookie_params
    params.require(:cookie).permit(:fillings, :quantity, :storage, :cooking_time)
  end
end
