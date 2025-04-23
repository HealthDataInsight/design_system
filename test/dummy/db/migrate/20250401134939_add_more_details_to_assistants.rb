class AddMoreDetailsToAssistants < ActiveRecord::Migration[7.1]
  def change
    add_column :assistants, :age, :integer
    add_column :assistants, :colour, :string
    add_column :assistants, :date_of_birth, :date
    add_column :assistants, :description, :text
    add_column :assistants, :desired_filling, :string
    add_column :assistants, :lunch_option, :string
    add_column :assistants, :phone, :string
    add_column :assistants, :terms_agreed, :boolean, default: false
    add_column :assistants, :website, :string

    add_reference :assistants, :role, null: false, foreign_key: true
  end
end
