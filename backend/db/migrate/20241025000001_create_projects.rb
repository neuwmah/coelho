class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.string :summary, null: false
      t.text :description
      t.json :tech_stack, null: false, default: []
      t.string :repo_url
      t.string :live_url
      t.boolean :featured, null: false, default: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :projects, :slug, unique: true
    add_index :projects, :featured
    add_index :projects, :position
  end
end
