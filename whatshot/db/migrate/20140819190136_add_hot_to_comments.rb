class AddHotToComments < ActiveRecord::Migration
  def change
    add_column :comments, :ratio, :integer
    add_column :comments, :hot, :boolean
  end
end
