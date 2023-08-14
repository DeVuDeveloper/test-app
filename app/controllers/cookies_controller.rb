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
        paid_amount = params[:cookie][:price].to_f
        create_service = Cookies::CreateService.new(current_user, @oven, cookie_params)
        validation_service = Cookies::ValidationService.new(cookie_params)

        if validation_service.validate.nil? && create_service.call
          if current_user.balance >= paid_amount
            current_user.subtract_from_balance(paid_amount)

            respond_to do |format|
              format.html { redirect_to ovens_path, notice: "Cookies were successfully created." }
              format.turbo_stream.append("cookies", partial: "cookies/created_cookie")
            end
          else
            respond_to do |format|
              format.html { redirect_to ovens_path, alert: "Insufficient funds." }
              format.turbo_stream { flash.now[:alert] = "Insufficient funds." }
            end
          end
        else
          @cookie = @oven.cookies.build(cookie_params)
          flash.now[:alert] = validation_service.validate || create_service.error_message
          respond_to do |format|
            format.html { render :new, alert: flash.now[:alert] }
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

  def claim_change
    paid_amount = params[:paid_amount].to_f
    total_price = params[:total_price].to_f

    change_to_claim = paid_amount - total_price

    if change_to_claim.positive?
      current_user.add_to_balance(change_to_claim)
      render json: {success: true, message: "Change successfully claimed."}
    else
      render json: {success: false, message: "Unable to claim change."}
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
