FactoryBot.define do
  factory :cookie, class: "Cookie" do
    storage { association(:oven) }
    fillings { "MyString" }
    quantity { 1 }
    cooking_time { 10 }
  end
end
