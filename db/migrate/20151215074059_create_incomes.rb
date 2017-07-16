class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.string :title
      t.text :description
      t.integer :amount
      t.datetime :date
      t.references :member, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :incomes, [:member_id, :created_at]
  end
end
  