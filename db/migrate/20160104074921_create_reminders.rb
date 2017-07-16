class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.text :title
      t.datetime :date_notify
      t.string :type

      t.timestamps null: false
    end
  end
end
