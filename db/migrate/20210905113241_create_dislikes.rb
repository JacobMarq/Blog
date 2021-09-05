class CreateDislikes < ActiveRecord::Migration[6.1]
  def change
    create_table :dislikes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :article, optional: true, foreign_key: true
      t.references :comment, optional: true, foreign_key: true
      
      t.timestamps
    end
  end
end
