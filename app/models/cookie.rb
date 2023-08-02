class Cookie < ApplicationRecord
  attr_accessor :quantity
  belongs_to :storage, polymorphic: true
  validates :storage, presence: true

  def ready?
    true
  end
end
