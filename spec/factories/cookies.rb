FactoryBot.define do
  factory :cookie, class: "Cookie" do
    storage { association(:oven) }
    fillings { "MyString" }
  end
end
