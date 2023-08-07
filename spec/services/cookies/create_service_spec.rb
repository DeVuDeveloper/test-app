require "rails_helper"

RSpec.describe Cookies::CreateService, type: :service do
  let(:user) { create(:user) }
  let(:oven) { create(:oven, user: user) }

  describe "#call" do
    context "with valid params" do
      let(:valid_cookie_params) do
        {
          fillings: "Chocolate",
          quantity: 2,
          cooking_time: 25
        }
      end

      it "creates cookies and returns true" do
        service = described_class.new(oven, valid_cookie_params)
        expect(service.call).to eq(2)
        expect(Cookie.count).to eq(2)
      end
    end

    context "with invalid params" do
      it "raises a validation error for blank fillings" do
        invalid_cookie_params = {
          fillings: "",
          quantity: 1,
          cooking_time: 25
        }

        service = described_class.new(oven, invalid_cookie_params)

        expect { service.call }.to raise_error(Cookies::CreateService::ValidationError)
      end

      it "raises a validation error for invalid quantity" do
        invalid_cookie_params = {
          fillings: "Chocolate",
          quantity: 0,
          cooking_time: 25
        }

        service = described_class.new(oven, invalid_cookie_params)

        expect { service.call }.to raise_error(Cookies::CreateService::ValidationError)
      end

      it "raises a validation error for invalid cooking time" do
        invalid_cookie_params = {
          fillings: "Chocolate",
          quantity: 1,
          cooking_time: -5
        }

        service = described_class.new(oven, invalid_cookie_params)

        expect { service.call }.to raise_error(Cookies::CreateService::ValidationError)
      end
    end
  end
end
