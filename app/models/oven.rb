class Oven < ActiveRecord::Base
  belongs_to :user
  has_many :cookies, as: :storage, dependent: :destroy

  validates :user, presence: true

  broadcasts_to ->(oven) { "ovens" }, inserts_by: :prepend

  delegate :fillings, :ready?, :cooked_at, to: :first_cookie, prefix: true, allow_nil: true

  def first_cookie
    cookies.first
  end
  
  def time_left_for_first_cookie
    first_cookie = self.first_cookie
    return 0 if first_cookie.nil? || first_cookie.cooked_at.nil?
    time_left = first_cookie.cooked_at - Time.now
    [time_left, 0].max
  end
end