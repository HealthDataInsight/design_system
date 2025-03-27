class CreateAssistants < ActiveRecord::Migration[7.1]
  def change
    create_table :assistants do |t|
      t.boolean :is_active, default: false
      t.date :date_of_birth
      t.references :department, null: false, foreign_key: true
      t.string :role, null: false
      t.string :title

      t.timestamps
    end
  end
end
