class AddCatToIncomes < ActiveRecord::Migration
  def change
  	add_reference :incomes, :category, index: true
  end
end
