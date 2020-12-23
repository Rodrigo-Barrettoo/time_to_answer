class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.string :addres
      t.string :gender
      t.date :birthdate
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
