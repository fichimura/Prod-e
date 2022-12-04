class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user


  validates_presence_of :avaliacao, if: :comentarios?
  validates_presence_of :comentarios, if: :avaliacao?

  validates :user, :course, presence: true
  validates_uniqueness_of :user_id, scope: :course_id  
  validates_uniqueness_of :course_id, scope: :user_id  
  validate :cant_subscribe_to_own_course 
  
   scope :pending_review, -> { where(avaliacao: [0, nil, ""], comentarios: [0, nil, ""]) }
   scope :reviewed, -> { where.not(avaliacao: [0, nil, ""]) }

  def to_s
    user.to_s + " " + course.to_s
  end

  after_save do
    unless avaliacao.nil? || avaliacao.zero?
      course.update_avaliacao
    end
  end

  after_destroy do
    course.update_avaliacao
  end
  

  protected
  def cant_subscribe_to_own_course
    if self.new_record?
      if self.user_id.present?
        if self.user_id == course.user_id
          errors.add(:base, "Vocẽ não pode inscrever-se no seu curso")
        end
      end
    end
  end


end
