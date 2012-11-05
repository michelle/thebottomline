class SeparateCardsTables < ActiveRecord::Migration
  def up
    drop_table :cards
    create_table :ecards do |t|
      t.string :sender
      t.string :recipient
      t.text :address
      t.text :message

      t.references :user
      t.timestamps
    end

    create_table :postcards do |t|
      t.string :sender
      t.string :recipient
      t.text :address_street
      t.text :address_city
      t.text :address_state
      t.text :address_zip
      t.text :message

      t.references :user
      t.timestamps
    end
  end

  def down
    create_table :cards do |t|
      t.string :recipient
      t.text :address
      t.text :message
      t.string :type
      t.string :sender

      t.references :user
      t.timestamps
    end
    drop_table :ecards
    drop_table :postcards
  end
end
