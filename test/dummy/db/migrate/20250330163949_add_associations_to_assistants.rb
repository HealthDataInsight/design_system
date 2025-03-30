class AddAssociationsToAssistants < ActiveRecord::Migration[7.1]
  def change
    add_reference :assistants, :department, foreign_key: true
    add_reference :assistants, :role, foreign_key: true
  end
end
