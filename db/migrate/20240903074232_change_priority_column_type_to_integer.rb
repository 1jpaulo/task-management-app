class ChangePriorityColumnTypeToInteger < ActiveRecord::Migration[7.2]
  def change
    change_column :tasks, :priority, :integer
  end
end
