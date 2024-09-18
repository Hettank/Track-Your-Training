class CreateBatches < ActiveRecord::Migration[7.1]
  def change
    create_table :batches do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :duration
      t.text :resources
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
