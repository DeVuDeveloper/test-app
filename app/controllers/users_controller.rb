class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update, :add_balance]

  def add_balance
    if current_user.update(user_params)
      respond_to do |format|
        format.html { redirect_to ovens_path, notice: "Balance added successfully." }
        format.turbo_stream
      end
    else
      render :show, alert: "Failed to add balance."
    end
  end

  private

  def user_params
    params.require(:user).permit(:balance)
  end
end
