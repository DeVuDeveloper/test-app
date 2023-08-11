class OvensController < ApplicationController
  before_action :authenticate_user!
  before_action :set_oven, only: [:show, :empty, :oven_status]

  def index
    @ovens = current_user.ovens
    @oven = Oven.first
    @cookie = Cookie.new
  end

  def empty
    empty_oven_cookies
    respond_to_oven_empty
  end

  def oven_status
    render json: oven_status_json
  end

  private

  def set_oven
    @oven = current_user.ovens.find_by!(id: params[:id])
  end

  def empty_oven_cookies
    @oven.cookies&.update(storage: current_user)
  end

  def respond_to_oven_empty
    respond_to do |format|
      format.html { redirect_to oven_path(@oven) }
      format.turbo_stream
    end
  end

  def toggle_status
    oven = Oven.find(params[:id])
    new_status = params[:online] == "true"

    if oven.update(online: new_status)
      render json: {new_status: oven.online ? "Online" : "Offline"}
    else
      render json: {error: "Failed to toggle oven status"}, status: :unprocessable_entity
    end
  end

  def oven_status_json
    {ready: @oven.first_cookie_ready?, time_left: @oven.time_left_for_first_cookie}
  end
end
