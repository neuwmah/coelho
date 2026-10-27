class CreateExperiences < ActiveRecord::Migration[7.2]
  def change
    create_table :experiences do |t|
      t.string :company, null: false
      t.string :role, null: false
      t.string :location
      t.date :started_on, null: false
      t.date :ended_on
      t.boolean :current, null: false, default: false
      t.text :description
      t.json :highlights, null: false, default: []

      t.timestamps
    end

    add_index :experiences, :started_on
  end
end
