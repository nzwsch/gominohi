class CreateGomiTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :gomi_types do |t|
      t.integer :type
      t.string :name

      t.timestamps
    end
  end
end
