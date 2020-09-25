class CreateSukkis < ActiveRecord::Migration[6.0]
  def change
    create_table :sukkis do |t|
      t.integer :suki
      t.references :user, null: false, foreign_key: true
      t.references :skicker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
