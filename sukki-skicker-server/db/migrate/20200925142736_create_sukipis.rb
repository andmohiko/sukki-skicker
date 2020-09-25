class CreateSukipis < ActiveRecord::Migration[6.0]
  def change
    create_table :sukipis do |t|
      t.string :name
      t.integer :suki
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
