require "rails_helper"

RSpec.describe "Oven Cookies", type: :feature do
  let(:oven) { create(:oven) }

  scenario "preparing a batch of cookies with the same filling" do
    visit oven_path(oven)

    fill_in "Fillings", with: "Chocolate Chip"
    click_button "Prepare Batch"

    expect(page).to have_content('Batch of cookies with filling "Chocolate Chip" is prepared.')
    expect(oven.cookies.count).to eq(12)
    expect(oven.cookies.pluck(:fillings).uniq).to contain_exactly("Chocolate Chip")
  end

  scenario "removing the cookies into the store inventory after cooking" do
    visit oven_path(oven)
    click_button "Remove Cookies"

    expect(page).to have_content("12 cookies have been moved to the store inventory.")
    expect(oven.cookies.count).to eq(0)
  end

  scenario "cookies are not ready, and the page updates when cookies are cooked" do
    visit oven_path(oven)

    expect(page).to have_content("Cookies are not yet ready.")
    expect(page).to have_content("Cookies are now ready.")
  end
end
