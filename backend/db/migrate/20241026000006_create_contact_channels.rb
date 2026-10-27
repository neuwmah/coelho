class CreateContactChannels < ActiveRecord::Migration[7.2]
  def change
    create_table :contact_channels do |t|
      t.string :title, null: false
      t.string :subtitle, null: false
      t.string :icon, null: false
      t.string :href
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :contact_channels, :position
  end
end
