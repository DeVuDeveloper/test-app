class AddOnlineToOvens < ActiveRecord::Migration[7.0]
  def change
    add_column :ovens, :online, :boolean
  end
end
