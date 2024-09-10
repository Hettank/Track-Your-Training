class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :duration
      t.integer :user_id
      t.text :description
      t.string :category
      t.string :level
      t.text :prerequisites
      t.text :instructor_bio
      t.text :course_content
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
