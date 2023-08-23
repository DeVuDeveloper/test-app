# require "rails_helper"

# RSpec.describe Ovens::IndexComponent, type: :component do
#   let(:ovens) { create_list(:oven, 3) }  # Assuming you have a Factory or Fixture for Oven

#   it "renders a list of ovens with Turbo Frame" do
#     render_inline(Ovens::IndexComponent.new(ovens: ovens))

#     expect(page).to have_selector("h3", text: "My Ovens")
#     expect(page).to have_selector(".row .col-md-6")
#     expect(page).to have_selector(".list-group.ovens")

#     ovens.each do |oven|
#       expect(page).to have_selector("turbo-frame#ovens")
#       expect(page).to have_content(oven.name)
#     end
#   end
# end
