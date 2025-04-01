class AddDetailsToAssistants < ActiveRecord::Migration[7.1]
  def change
    add_column :assistants, :email, :string
    add_column :assistants, :password, :string
  end
end
