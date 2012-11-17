class AddBackgroundToCards < ActiveRecord::Migration
  def up
    add_column :postcards, :background, :string
    add_column :ecards, :background, :string
  end
  def down
    remove_column :postcards, :background
    remove_column :ecards, :background
  end
end
