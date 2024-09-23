class AddDefaultToTaskStatus < ActiveRecord::Migration[7.1]
  def change
    change_column_default :tasks, :status, 0
  end
end
