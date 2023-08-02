class OvensController < ApplicationController
  before_action :authenticate_user!
  before_action :set_oven, only: [:show, :empty]

  def index
    @ovens = current_user.ovens
  end

  def show
  end

  def empty
    @oven.cookies&.update(storage: current_user)
    redirect_to oven_path(@oven)
  end

  private

  def set_oven
    @oven = current_user.ovens.find_by!(id: params[:id])
  end
end
