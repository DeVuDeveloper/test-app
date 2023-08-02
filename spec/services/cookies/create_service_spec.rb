require "rails_helper"

RSpec.describe "CookiesController", type: :request do
  let(:user) { create(:user) }
  let(:oven) { create(:oven, user: user) }

  describe "GET new" do
    context "when not authenticated" do
      it "blocks access" do
        get new_oven_cookie_path(oven)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when authenticated" do
      before { sign_in user }

      it "allows access" do
        get new_oven_cookie_path(oven)
        expect(response).to have_http_status(:ok)
      end

      context "when the oven has cookies" do
        let!(:cookie) { create(:cookie, storage: oven) }

        it "redirects to the oven with an alert message" do
          get new_oven_cookie_path(oven)
          expect(response).to redirect_to oven_path(oven)
          expect(flash[:alert]).to eq("Cookies are already in the oven!")
        end
      end

      context "when the oven has no cookies" do
        it "renders the new template" do
          get new_oven_cookie_path(oven)
          expect(response).to render_template(:new)
        end
      end

      context "when an invalid oven is supplied" do
        it "redirects to the ovens path with an alert message" do
          get new_oven_cookie_path(9999) # Invalid oven ID
          expect(response).to redirect_to ovens_path
          expect(flash[:alert]).to eq("Oven not found")
        end
      end
    end
  end

  describe "POST create" do
    let(:valid_params) do
      {cookie: attributes_for(:cookie, fillings: "Chocolate Chip", quantity: 5)}
    end

    context "when not authenticated" do
      it "blocks access" do
        post oven_cookies_path(oven), params: valid_params
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "when authenticated" do
      before { sign_in user }

      it "allows access" do
        post oven_cookies_path(oven), params: valid_params
        expect(response).to have_http_status(:redirect)
      end

      context "when the oven is found" do
        it "creates a new cookie and redirects to the oven with a notice" do
          expect {
            post oven_cookies_path(oven), params: valid_params
          }.to change { Cookie.count }.by(5)

          expect(response).to redirect_to oven_path(oven)
          expect(flash[:notice]).to eq("Cookies were successfully created.")
        end
      end

      context "when an invalid oven is supplied" do
        it "redirects to the ovens path with an alert message" do
          post oven_cookies_path(9999), params: valid_params
          expect(response).to redirect_to ovens_path
          expect(flash[:alert]).to eq("Oven not found")
        end
      end
    end
  end
end
