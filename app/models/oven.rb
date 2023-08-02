class Oven < ActiveRecord::Base
  belongs_to :user
  has_many :cookies, as: :storage, dependent: :destroy

  validates :user, presence: true

  broadcasts_to ->(oven) { "ovens" }, inserts_by: :prepend

  delegate :fillings, :ready?, to: :first_cookie, prefix: true, allow_nil: true

  def first_cookie
    cookies.first
  end
end
