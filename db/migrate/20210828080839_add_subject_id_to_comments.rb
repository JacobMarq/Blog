class AddSubjectIdToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :subject, optional: true, foreign_key: { to_table: :comments }
  end
end
