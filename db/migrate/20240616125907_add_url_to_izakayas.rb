class AddUrlToIzakayas < ActiveRecord::Migration[7.1]
  def change
    add_column :izakayas, :url, :text
  end
end
