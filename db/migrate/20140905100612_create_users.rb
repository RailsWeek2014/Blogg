class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :name
      t.string :birthday
      t.string :city
      t.text :info
      t.string :homepage

      t.timestamps
    end
  end
end
