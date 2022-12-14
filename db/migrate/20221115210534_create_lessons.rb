class CreateLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :lessons do |t|
      t.string :titulo
      t.text :conteudo
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
