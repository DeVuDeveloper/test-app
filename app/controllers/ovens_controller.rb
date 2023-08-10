class OvensController < ApplicationController
  before_action :authenticate_user!
  before_action :set_oven, only: [:show, :empty, :oven_status]

  def index
    @ovens = current_user.ovens
    @oven = Oven.first
    @cookie = Cookie.new
  end

  def show
  end

  def empty
    @oven.cookies&.update(storage: current_user)
    respond_to do |format|
      format.html { redirect_to oven_path(@oven) }
      format.turbo_stream 
    end
  end

  def oven_status
    render json: {ready: @oven.first_cookie_ready?, time_left: @oven.time_left_for_first_cookie}
  end

  private

  def set_oven
    @oven = current_user.ovens.find_by!(id: params[:id])
  end
end
