class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.references :follower, null: false, foreign_key: { to_table: "Users" }
      t.references :follows, null: false, foreign_key: { to_table: "Users" }

      t.timestamps
    end
  end
end
