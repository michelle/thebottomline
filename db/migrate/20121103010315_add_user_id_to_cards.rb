class AddUserIdToCards < ActiveRecord::Migration
  def change
    change_table :cards do |t|
      t.references :user
    end
  end
end
