class AddDescriptionToPlans < ActiveRecord::Migration[7.1]
  def change
    add_column :plans, :description, :text
  end
end
