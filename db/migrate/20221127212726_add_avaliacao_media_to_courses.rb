class AddAvaliacaoMediaToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :avaliacao_media, :float, default: 0.0, null: false
  end
end
