class RemoveNotNullConstraintFromCommentIdInBatches < ActiveRecord::Migration[7.1]
  def change
    change_column_null :batches, :comment_id, true
  end
end
