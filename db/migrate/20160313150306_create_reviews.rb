class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :star
      t.text :text
      t.references :food_item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
