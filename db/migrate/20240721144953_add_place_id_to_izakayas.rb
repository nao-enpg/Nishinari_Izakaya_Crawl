class AddPlaceIdToIzakayas < ActiveRecord::Migration[7.1]
  def change
    add_column :izakayas, :place_id, :string
  end
end
