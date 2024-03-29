Warden.test_mode!

# Feature: User delete
#   As a user
#   I want to delete my user profile
#   So I can close my account
feature "User delete", :devise, :js do
  include Warden::Test::Helpers
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User can delete own account
  #   Given I am signed in
  #   When I delete my account
  #   Then I should see an account deleted message
  # scenario 'user can delete own account' do
  #   user = create(:user)
  #   login_as(user, scope: :user)
  #   visit edit_user_registration_path(user)
  #   click_button 'Cancel my account'
  #   expect(page).to have_content 'Your account has been successfully cancelled.'
  # end
end
