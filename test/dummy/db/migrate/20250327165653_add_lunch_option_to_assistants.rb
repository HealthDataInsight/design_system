class AddLunchOptionToAssistants < ActiveRecord::Migration[7.1]
  def change
    add_column :assistants, :lunch_option, :string
  end
end
