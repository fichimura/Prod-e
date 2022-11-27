class AddFieldsToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :linguagens, :string
    add_column :courses, :nivel, :string, default: "Iniciante", null: false
  end
end
