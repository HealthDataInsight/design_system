class AddIsActiveToAssistants < ActiveRecord::Migration[7.1]
  def change
    add_column :assistants, :is_active, :boolean
  end
end
