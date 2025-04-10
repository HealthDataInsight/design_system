class CreateDepartments < ActiveRecord::Migration[7.1]
  def change
    create_table :departments do |t|
      t.string :title

      t.timestamps
    end

    change_table :assistants do |t|
      t.references :department, null: false, foreign_key: true
    end
  end
end
