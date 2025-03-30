class CreateAssistants < ActiveRecord::Migration[7.1]
  def change
    create_table :assistants do |t|
      t.boolean :terms_agreed, default: false
      t.date :date_of_birth
      t.string :lunch_option
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
