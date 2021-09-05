class AddUserToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :user, optional: true, foreign_key: true
  end
end
