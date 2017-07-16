class AddCategoryToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :category, :text
  end
end
