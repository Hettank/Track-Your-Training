class AddTrainerIdToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :trainer_id, :integer
  end
end
