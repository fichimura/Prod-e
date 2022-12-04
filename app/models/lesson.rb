class Lesson < ApplicationRecord
  belongs_to :course
  validates :titulo, :conteudo, :course, presence: true
  has_many :user_lessons, dependent: :destroy

  extend FriendlyId
  friendly_id :titulo, use: :slugged

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  def to_s
    titulo
  end

  def viewed(user)
    self.user_lessons.where(user: user).present?
    #self.user_lessons.where(user_id: [user_id], lesson_id: [self.id]).present?
    
  end

end
