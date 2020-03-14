class CreateGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :genres do |t|
      t.string :name
      t.integer :genre_api_id

      t.timestamps
    end
  end
end
