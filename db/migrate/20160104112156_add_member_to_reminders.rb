class AddMemberToReminders < ActiveRecord::Migration
  def change
    add_reference :reminders, :member, index: true, foreign_key: true
  end
end
