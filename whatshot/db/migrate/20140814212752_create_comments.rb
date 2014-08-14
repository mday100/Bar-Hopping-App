class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :location, index: true
      t.text :body

      t.timestamps
    end
  end
end
