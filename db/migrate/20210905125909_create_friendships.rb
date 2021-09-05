class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.references :follower, null: false, foreign_key: { to_table: "User" }
      t.references :followed, null: false, foreign_key: { to_table: "User" }

      t.timestamps
    end
  end
end
