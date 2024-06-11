class CreateIzakayas < ActiveRecord::Migration[7.1]
  def change
    create_table :izakayas do |t|
      t.string :name
      t.string :formatted_address
      t.float :lat
      t.float :lng
      t.string :photo_reference
      t.string :image
      t.string :opening_hours
      t.string :description

      t.timestamps
    end
  end
end
