class CreateSearchMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :search_movies do |t|
      t.references :search, foreign_key: true
      t.references :movie, foreign_key: true

      t.timestamps
    end
  end
end
