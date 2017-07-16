class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.text :title
      t.text :description
      t.text :type
      t.references :member, index: true, foreign_key: true


      t.timestamps null: false
    end
  end
end
