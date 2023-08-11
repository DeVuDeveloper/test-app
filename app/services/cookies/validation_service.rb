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

      return "Fillings must be present!" if fillings.empty?
      return "Quantity must be at least 5!" if quantity < 5
      return "Cooking time must be greater than 25" if cooking_time < 25

      nil
    end
  end
end
