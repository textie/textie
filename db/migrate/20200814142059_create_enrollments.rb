class CreateEnrollments < ActiveRecord::Migration[6.0]
  def change
    create_table :enrollments do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.references :course, null: false, foreign_key: true
    end

    add_index :enrollments, [:user_id, :course_id], unique: true
  end
end
