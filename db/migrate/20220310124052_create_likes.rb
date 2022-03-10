class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :profile_like
      t.references :liked_post

      t.timestamps
    end
  end
end
