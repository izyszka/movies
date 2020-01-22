class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :director
      t.text :description
      t.string :length

      t.timestamps
    end
  end
end
