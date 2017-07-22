class DeleteCategoryAndAddCategoryIdInExpenses < ActiveRecord::Migration
  def change
  	 remove_column :expenses, :category, :text
  	 add_column :expenses, :category_id, :integer
  end
end
