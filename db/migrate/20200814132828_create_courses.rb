class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :title, null: false, blank: false
      t.text :description, null: false, blank: false
      t.references :author, null: false, foreign_key: { to_table: "users" }

      t.timestamps
    end
  end
end
