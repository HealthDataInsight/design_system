class AddAssociationsToAssistants < ActiveRecord::Migration[7.1]
  def change
    add_reference :assistants, :department, null: false, foreign_key: true
    add_reference :assistants, :office, null: false, foreign_key: true
    add_reference :assistants, :role, null: false, foreign_key: true
  end
end
