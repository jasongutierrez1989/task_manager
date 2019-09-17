class AddLocationNameToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :location_name, :string
  end
end
