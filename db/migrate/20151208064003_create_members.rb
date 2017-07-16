class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :member_name
      t.string :member_email
      t.string :member_country

      t.timestamps null: false
    end
  end
end
