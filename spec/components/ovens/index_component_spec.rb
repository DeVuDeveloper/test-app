require "rails_helper"

RSpec.describe Ovens::IndexComponent, type: :component do
  let(:ovens) do
    [
      Oven.new(id: 1, name: "Oven 1"),
      Oven.new(id: 2, name: "Oven 2"),
      Oven.new(id: 3, name: "Oven 3")
    ]
  end

  it "renders a list of ovens" do
    render_inline(described_class.new(ovens))

    expect(page).to have_css("h3", text: "My Ovens")
    expect(page).to have_css("ul.ovens") do |ul|
      expect(ul).to have_css("li", count: 3)
      expect(ul).to have_css("li", text: "Oven 1")
      expect(ul).to have_css("li", text: "Oven 2")
      expect(ul).to have_css("li", text: "Oven 3")
    end
  end
end
