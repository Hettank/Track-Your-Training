class AddBatchIdToTasks < ActiveRecord::Migration[7.1]
  def change
    add_reference :tasks, :batch, null: false, foreign_key: true
  end
end
