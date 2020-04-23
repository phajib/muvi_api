class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :movie_id
      t.string :movie_title
      t.string :content
      t.string :username
      t.string :profile_picture

      t.timestamps
    end
  end
end
