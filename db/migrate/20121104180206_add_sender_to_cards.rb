class AddSenderToCards < ActiveRecord::Migration
  def up
    add_column :cards, :sender, :string
  end

  def down
    remove_column :cards, :sender, :string
  end
end
