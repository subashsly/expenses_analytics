class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
    	t.string :title
    	t.text :description
    	t.integer :amount
    	t.datetime :date
    	t.references :member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
