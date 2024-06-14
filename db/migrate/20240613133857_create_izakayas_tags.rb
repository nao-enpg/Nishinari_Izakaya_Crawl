class CreateIzakayasTags < ActiveRecord::Migration[7.1]
  def change
    create_join_table :izakayas, :tags do |t|
      t.index :izakaya_id
      t.index :tag_id
    end
  end
end
