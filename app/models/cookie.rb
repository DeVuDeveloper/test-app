class Cookie < ApplicationRecord
  attr_accessor :quantity
  attr_accessor :cooking_time
  belongs_to :storage, polymorphic: true
  validates :storage, presence: true

  def ready?
    cooked_at.present? && cooked_at <= Time.now
  end
end
