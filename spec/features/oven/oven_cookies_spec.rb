# require "rails_helper"

# RSpec.describe "Oven Cookies", type: :feature do
#   let(:user) { create_and_signin }
#   let!(:oven) { user.ovens.first }

#   before do
#     visit ovens_path
#   end

#   scenario "preparing a batch of cookies with the same filling" do
#     find('[data-filling="Mango"]')
#     click_link_or_button  "Mango"
#     fill_in "Qty", with: 10
#     fill_in "Time", with: 25
#     click_button "Start"
#     expect(page).to_not have_content("Cookie are Ready")
#     expect(oven.cookies.count).to eq(10)
#     expect(oven.cookies.pluck(:fillings).uniq).to contain_exactly("Mango")
#   end

#   scenario "trying to bake more than 20 cookies" do
#     fill_in "Fillings", with: "Chocolate Chip"
#     fill_in "Quantity", with: 25
#     fill_in "Cooking time", with: 25
#     click_button "Mix and bake"

#     expect(page).to have_content("Quantity : please enter a valid quantity.")
#     expect(oven.cookies.count).to eq(0)
#   end

#   scenario "cookies are already in the oven" do
#     fill_in "Fillings", with: "Chocolate Chip"
#     fill_in "Quantity", with: 5
#     fill_in "Cooking time", with: 25
#     click_button "Mix and bake"

#     click_link_or_button "Prepare Cookies"

#     expect(page).to have_content("Cookies are already in the oven!")
#     expect(current_path).to eq(oven_path(oven))
#     expect(page).to_not have_button("Mix and bake")
#   end
# end
