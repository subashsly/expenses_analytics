class ChangeDateNotifyFormatInReminder < ActiveRecord::Migration
  def change
  	change_column :reminders, :date_notify, :date
  end
end
