class CreateAssistants < ActiveRecord::Migration[7.1]
  def change
    create_table :assistants do |t|
      t.boolean :terms_agreed, default: false
      t.date :date_of_birth
      t.integer :age
      t.string :colour
      t.string :desired_filling
      t.string :email
      t.string :lunch_option
      t.string :password
      t.string :phone
      t.string :title
      t.string :website
      t.text :description

      t.timestamps
    end
  end
end
