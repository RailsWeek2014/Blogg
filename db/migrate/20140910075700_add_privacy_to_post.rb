class AddPrivacyToPost < ActiveRecord::Migration
  def change
    add_column :posts, :privacy, :boolean
  end
end
