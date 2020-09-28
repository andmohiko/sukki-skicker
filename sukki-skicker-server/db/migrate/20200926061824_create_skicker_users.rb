class CreateSkickerUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :skicker_users do |t|
      t.references :skicker, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
