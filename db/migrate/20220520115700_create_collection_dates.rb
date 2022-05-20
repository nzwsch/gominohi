class CreateCollectionDates < ActiveRecord::Migration[6.1]
  def change
    create_table :collection_dates do |t|
      t.date :date,      null: false
      t.string :weekday, null: false

      t.references :collection_area, null: false, foreign_key: true
      t.references :gomi_type,       null: false, foreign_key: true

      t.timestamps
    end
  end
end
