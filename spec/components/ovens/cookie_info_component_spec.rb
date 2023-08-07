require "rails_helper"

RSpec.describe Ovens::CookieInfoComponent, type: :component do
  let(:user) { create(:user) }
  let(:oven) { create(:oven, user: user) }
  let!(:cookie) { create(:cookie) }

  it "renders the component" do
    oven_with_cookie = create(:oven, user: user)
    oven_with_cookie.cookies << cookie
    render_inline(described_class.new(oven: oven_with_cookie))

    expect(page).to have_selector("h5.text-primary", text: "Cookies in oven:")
    expect(page).to have_selector('.cookie-status[data-controller="cookies"]')
    expect(page).to have_selector('.timer.text-orange[data-target="cookies.timer"]')
    expect(page).to have_selector('.btn.btn-primary.btn-retrieve.hidden[data-target="cookies.button"][data-oven-id]')
    expect(page).to have_selector('.text-ready.text-success.hidden[data-target="cookies.ready"]')
    expect(page).to have_selector('.loader.hidden[data-target="cookies.loader"]')
    expect(page).to have_selector(".fas.fa-spinner.fa-spin")
  end

  it "renders empty oven message" do
    render_inline(described_class.new(oven: oven))

    expect(page).to have_selector("span.text-danger", text: "(Oven is empty)")
  end
end
