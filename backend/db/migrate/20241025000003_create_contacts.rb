class CreateContacts < ActiveRecord::Migration[7.2]
  def change
    create_table :contacts do |t|
      t.string :email, null: false
      t.string :phone
      t.string :location, null: false
      t.string :linkedin_url
      t.string :github_url
      t.string :twitter_url

      t.timestamps
    end
  end
end
