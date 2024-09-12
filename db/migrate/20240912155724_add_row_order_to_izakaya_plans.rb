class AddRowOrderToIzakayaPlans < ActiveRecord::Migration[7.1]
  def change
    add_column :izakaya_plans, :row_order, :integer
  end
end
