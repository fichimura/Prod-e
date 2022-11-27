class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :user


  validates :user, :course, presence: true
  validates_uniqueness_of :user_id, scope: :course_id  
  validates_uniqueness_of :course_id, scope: :user_id  
  validate :cant_subscribe_to_own_course 
  def to_s
    user.to_s + " " + course.to_s
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
