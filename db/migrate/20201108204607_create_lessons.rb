class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :course, null: false, foreign_key: true, index: false
      t.integer :order, null: false

      t.timestamps
    end

    add_index :lessons, [:course_id, :order], unique: true
  end
end
