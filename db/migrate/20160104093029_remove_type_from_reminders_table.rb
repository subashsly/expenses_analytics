class RemoveTypeFromRemindersTable < ActiveRecord::Migration
  def change
    remove_column :reminders, :type, :text
  end
end
