feature "Cooking cookies" do
  scenario "If custom validation is triggered" do
    user = create_and_signin
    user.ovens.first

    visit ovens_path

    expect(page).to_not have_content "Mango"
    expect(page).to_not have_content "Cookies are ready!"

    fill_in "Qty", with: "5"
    fill_in "Time", with: 20

    click_button "Start"

    expect(page).to have_content "No cookies for sale"
    expect(page).to have_content "Oven is empty"
    expect(page).to have_content "Fillings must be present"
  end
end
