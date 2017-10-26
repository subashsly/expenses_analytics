class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :phone_no
      t.string :address
      t.references :member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
