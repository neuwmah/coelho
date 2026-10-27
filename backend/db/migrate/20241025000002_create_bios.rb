class CreateBios < ActiveRecord::Migration[7.2]
  def change
    create_table :bios do |t|
      t.string :full_name, null: false
      t.string :headline, null: false
      t.text :summary, null: false
      t.string :location
      t.json :skills, null: false, default: []
      t.string :avatar_url
      t.string :resume_url

      t.timestamps
    end
  end
end
