module Cookies
  class ValidationService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def validate
      fillings = @params[:fillings].to_s
      quantity = @params[:quantity].to_i
      cooking_time = @params[:cooking_time].to_i
      price = @params[:price].to_f

      return "Fillings must be present!" if fillings.empty?
      return "Quantity must be at least 1!" if quantity < 1
      return "Cooking time must be greater than 25" if cooking_time < 25
      total_price = quantity * 1
      return "Please insert #{total_price} dollars" if price < total_price

      nil
    end
  end
end
