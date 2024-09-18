class DropTableName < ActiveRecord::Migration[7.1]
  def change
    drop_table :batches_users
  end
end
