class OvensController < ApplicationController
  before_action :authenticate_user!
  before_action :set_oven, only: [:show, :empty]

  def index
    @ovens = current_user.ovens
  end

  def show
  end

  def empty
    @oven.cookie.update!(storage: current_user) if @oven.cookie.present?
    redirect_to @oven
  end

  private

  def set_oven
    @oven = current_user.ovens.find_by!(id: params[:id])
  end
end
