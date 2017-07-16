class AddAmountToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :amount, :integer
  end
end
