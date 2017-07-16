class AddDescriptionToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :description, :text
  end
end
