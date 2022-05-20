class CreateGomiTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :gomi_types do |t|
      t.integer :kind, null: false
      t.string :name,  null: false

      t.timestamps
    end
  end
end
