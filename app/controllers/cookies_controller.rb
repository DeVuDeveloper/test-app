class CookiesController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :authenticate_user!
  before_action :set_oven, only: [:new, :create]

  def new
    if @oven.cookie.present?
      respond_to do |format|
        format.html { redirect_to @oven, alert: "Cookie is already in the oven" }
        format.turbo_stream { flash.now[:alert] = "Cookie is already in the oven" }
      end
    else
      @cookie = @oven.build_cookie
    end
  end

  def create
    @cookie = @oven.create_cookie!(cookie_params)
    if @cookie.save
      respond_to do |format|
        format.html { redirect_to @oven, notice: "Cookie was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Cookie was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_oven
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
  end

  def cookie_params
    params.require(:cookie).permit(:fillings)
  end
end
