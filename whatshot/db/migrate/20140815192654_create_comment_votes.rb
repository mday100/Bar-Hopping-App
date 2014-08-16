class CreateCommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
      t.references :comment, index: true
      t.references :user, index: true
      t.integer :value

      t.timestamps
    end
  end
end
