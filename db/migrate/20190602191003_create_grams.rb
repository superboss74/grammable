class CreateGrams < ActiveRecord::Migration[5.2]
  def change
    create_table :grams do |t|
      t.text
      t.timestamps
    end
  end
end