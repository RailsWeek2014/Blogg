class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :url
      t.string :string
      t.string :user_id
      t.string :integer

      t.timestamps
    end
  end
end
