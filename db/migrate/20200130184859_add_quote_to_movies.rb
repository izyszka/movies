class AddQuoteToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :quote, :text
  end
end
