class Cookie < ApplicationRecord
  belongs_to :storage, polymorphic: true

  validates :fillings, presence: true
  validates :storage, presence: true

  def ready?
    true
  end
end
