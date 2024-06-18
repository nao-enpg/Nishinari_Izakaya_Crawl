class CreateIzakayaPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :izakaya_plans do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :izakaya, null: false, foreign_key: true

      t.timestamps
    end
  end
end
