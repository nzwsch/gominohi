class CreateGomiTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :gomi_types, id: false do |t|
      t.integer :id,  null: false, primary_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
