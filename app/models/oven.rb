class Oven < ActiveRecord::Base
  belongs_to :user
  has_one :cookie, as: :storage, dependent: :destroy

  validates :user, presence: true

  broadcasts_to ->(oven) { "ovens"}, inserts_by: :prepend
end
