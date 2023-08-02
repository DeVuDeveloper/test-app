RSpec.describe Ovens::CookieInfoComponent, type: :component do
  let(:user) { create(:user) }
  let(:oven) { create(:oven, user: user) }
  let!(:cookie) { create(:cookie) }

  context "when the oven has cookies" do
    it "renders the cookies info" do
      oven_with_cookie = create(:oven, user: user)
      oven_with_cookie.cookies << cookie

      render_inline(Ovens::CookieInfoComponent.new(oven_with_cookie))

      expect(page).to have_selector(".cookie-info")
      expect(page).to have_selector("h4", text: "Cookie in oven:")
      expect(page).to have_selector("p", text: "#{oven_with_cookie.cookies.size} with #{cookie.fillings}")
      expect(page).to have_selector(".text-success", text: "(Your Cookie is Ready)")
      expect(page).to have_button("Retrieve Cookies")
    end
  end

  context "when the oven has no cookies" do
    it "renders the empty oven message" do
      render_inline(Ovens::CookieInfoComponent.new(oven))

      expect(page).to have_selector(".cookie-info")
      expect(page).to have_selector("h4", text: "Cookie in oven:")
      expect(page).to have_selector("p", text: "None")
      expect(page).to have_selector(".text-danger", text: "(Oven is empty)")
    end
  end
end
