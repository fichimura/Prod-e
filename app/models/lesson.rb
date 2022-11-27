class Lesson < ApplicationRecord
  belongs_to :course
  validates :titulo, :conteudo, :course, presence: true


  extend FriendlyId
  friendly_id :titulo, use: :slugged

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  def to_s
    titulo
  end
end
