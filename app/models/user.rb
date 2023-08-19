class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :ovens, dependent: :destroy
  has_many :stored_cookies, class_name: "Cookie", as: :storage
  before_create :setup_first_oven

  def add_to_balance(amount)
    update(balance: balance + amount)
  end

  def subtract_from_balance(amount)
    update(balance: balance - amount)
  end

  def change_to_claim(price, paid_amount)
    overpaid_amount = paid_amount - price
    overpaid_amount.positive? ? overpaid_amount : 0
  end

  def setup_first_oven
    ovens.new(name: "My First Oven")
  end
end
