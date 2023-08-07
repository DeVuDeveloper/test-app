fillings = ["peanut butter", "chocolate", "marshmallow", "icing"]

50.times do
  Order.create(
    customer_name: Faker::Name.name,
    item: "Cookies with #{fillings.sample}",
    quantity: Faker::Number.between(from: 2, to: 24),
    pick_up_at: Faker::Number.between(from: 1, to: 10).days.from_now
  )
end
