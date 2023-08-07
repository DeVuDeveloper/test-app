feature "Cooking cookies" do
  scenario "Cooking cookies" do
    user = create_and_signin
    oven = user.ovens.first

    visit oven_path(oven)

    expect(page).to_not have_content "Chocolate Chip"
    expect(page).to_not have_content "Your Cookie is Ready"

    click_link_or_button "Prepare Cookies"
    fill_in "Fillings", with: "Chocolate Chip"
    fill_in "Quantity", with: 1
    fill_in "Cooking time", with: 25
    click_button "Mix and bake"

    expect(current_path).to eq(oven_path(oven))
    expect(page).to have_content "Chocolate Chip"
    expect(page).to have_content "1 cookie with Chocolate Chip"
    expect(page).to have_content "Cookies are ready!"
  end

  scenario "Trying to bake a cookie while oven is full" do
    user = create_and_signin
    oven = user.ovens.first

    visit oven_path(oven)

    click_link_or_button "Prepare Cookies"
    fill_in "Fillings", with: "Chocolate Chip"
    fill_in "Quantity", with: 1
    fill_in "Cooking time", with: 25
    click_button "Mix and bake"

    click_link_or_button "Prepare Cookies"
    expect(page).to have_content "Cookies are already in the oven!"
    expect(current_path).to eq(oven_path(oven))
    expect(page).to_not have_button "Mix and bake"
  end
end
