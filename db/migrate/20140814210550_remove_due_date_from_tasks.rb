class RemoveDueDateFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :due_date, :datetime
  end
end
