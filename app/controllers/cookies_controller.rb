class CookiesController < ApplicationController
  rescue_from Cookies::CreateService::ValidationError, with: :render_form_with_errors
  before_action :authenticate_user!
  before_action :set_oven, only: [:new, :create]

  def new
    if @oven.cookies.any?
      respond_to do |format|
        format.html { redirect_to @oven, alert: "Cookies are already in the oven!" }
        format.turbo_stream { flash.now[:alert] = "Cookies are already in the oven!" }
      end
    else
      @cookie = @oven.cookies.build
    end
  end

  def create
    create_service = Cookies::CreateService.new(@oven, @cookie, cookie_params)
    if create_service.call
      respond_to do |format|
        format.html { redirect_to oven_path(@oven), notice: "Cookies were successfully created." }
        format.turbo_stream { flash.now[:notice] = "Cookies were successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def render_form_with_errors(exception)
    @cookie = exception.cookie
    render :new, status: :unprocessable_entity
  end

  def set_oven
    @oven = current_user.ovens.includes(:cookies).find_by(id: params[:oven_id])
    redirect_to ovens_path, alert: "Oven not found" unless @oven
  end

  def cookie_params
    params.require(:cookie).permit(:fillings, :quantity, :storage)
  end
end
