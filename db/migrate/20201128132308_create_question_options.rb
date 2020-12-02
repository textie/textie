class CreateQuestionOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :question_options do |t|
      t.text :value, null: false
      t.boolean :correct, null: false, default: false
      t.references :question, null: false, foreign_key: { to_table: "exercises" }

      t.timestamps
    end
  end
end
