class RemoveResourcesFromBatches < ActiveRecord::Migration[7.1]
  def change
    remove_column :batches, :resources, :text
  end
end
