class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :recipient
      t.text :address
      t.text :message
      t.string :type

      t.timestamps
    end
  end
end
