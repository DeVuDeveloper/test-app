module OvenLoading
  extend ActiveSupport::Concern

  included do
    before_action :load_oven, only: [:new, :create]
  end

  private

  def load_oven
    @oven = current_user.ovens.includes(:cookies).find_by(id: params[:oven_id])
    redirect_to ovens_path, alert: "Oven not found" unless @oven
  end
end
