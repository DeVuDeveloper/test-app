require "rails_helper"

RSpec.describe "Oven Cookies", type: :feature do
  let(:user) { create_and_signin }
  let!(:oven) { user.ovens.first }

  before do
    visit oven_path(oven)
    click_link_or_button "Prepare Cookies"
  end

  scenario "preparing a batch of cookies with the same filling" do
    fill_in "Fillings", with: "Chocolate Chip"
    fill_in "Quantity", with: 10
    click_button "Mix and bake"
    expect(page).to have_content("Your Cookie is Ready")
    expect(oven.cookies.count).to eq(10)
    expect(oven.cookies.pluck(:fillings).uniq).to contain_exactly("Chocolate Chip")
  end

  scenario "trying to bake more than 20 cookies" do
    fill_in "Fillings", with: "Chocolate Chip"
    fill_in "Quantity", with: 25
    click_button "Mix and bake"

    expect(page).to have_content("Quantity : you can't put more than 20 cookies in the oven.")
    expect(oven.cookies.count).to eq(0)
  end

  scenario "trying to bake with an invalid quantity" do
    fill_in "Fillings", with: "Chocolate Chip"
    fill_in "Quantity", with: "abc"
    click_button "Mix and bake"

    expect(page).to have_content("Quantity : please enter a valid quantity.")
    expect(oven.cookies.count).to eq(0)
  end

  scenario "removing the cookies into the store inventory after cooking" do
    fill_in "Fillings", with: "Chocolate Chip"
    fill_in "Quantity", with: "15"
    click_button "Mix and bake"
    click_button "Retrieve Cookies"

    expect(oven.cookies.count).to eq(0)
  end

  scenario "cookies are already in the oven" do
    fill_in "Fillings", with: "Chocolate Chip"
    fill_in "Quantity", with: 5
    click_button "Mix and bake"

    click_link_or_button "Prepare Cookies"

    expect(page).to have_content("Cookies are already in the oven!")
    expect(current_path).to eq(oven_path(oven))
    expect(page).to_not have_button("Mix and bake")
  end

  scenario "total count of cookies in the store inventory" do
    fill_in "Fillings", with: "Chocolate Chip"
    fill_in "Quantity", with: "15"
    click_button "Mix and bake"
    click_button "Retrieve Cookies"
    visit root_path
    within ".store-inventory" do
      expect(page).to have_content("15 Cookies")
    end
  end
end
