class CreateSkickers < ActiveRecord::Migration[6.0]
  def change
    create_table :skickers do |t|
      t.string :name
      t.integer :power
      t.integer :cost

      t.timestamps
    end
  end
end
