class AddPriceToCookies < ActiveRecord::Migration[7.0]
  def change
    add_column :cookies, :price, :decimal
  end
end
