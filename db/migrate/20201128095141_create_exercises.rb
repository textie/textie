class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.references :lesson, null: false, foreign_key: true
      t.string :type, null: false

      t.timestamps
    end
  end
end
