class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.integer :movie_id, null: false
      t.integer :user_id, null: false, unique:true

      t.timestamps
    end
  end
end
