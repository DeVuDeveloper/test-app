class AddCookedAtToCookies < ActiveRecord::Migration[7.0]
  def change
    add_column :cookies, :cooked_at, :datetime
  end
end