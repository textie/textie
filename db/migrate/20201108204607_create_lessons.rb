class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :course, null: false, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
