class CreateBatchesUsersJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :batches_users do |t|
      t.belongs_to :batch
      t.belongs_to :user
    
      t.timestamps
    end
  end
end
