class Course < ApplicationRecord
    validates :titulo, :linguagens , :nivel,  presence: true
    validates :descricao, presence: true, length: { :minimum => 5 }
    
    belongs_to :user
    has_many :lessons, dependent: :destroy
    has_many :enrollments
    has_many :user_lessons, through: :lessons

    def to_s
        titulo
    end
   
    extend FriendlyId
    friendly_id :titulo, use: :slugged

    NIVEIS = [:"Iniciante", :"Intermediario", :"Avançado"]
    def self.niveis
      NIVEIS.map { |nivel| [nivel, nivel] }
    end

    include PublicActivity::Model
    tracked owner: Proc.new{ |controller, model| controller.current_user } 

    def inscritos(user)
      self.enrollments.where(user_id: [user.id], course_id: [self.id]).empty?
    end


    def progress(user)
      unless self.lessons.count == 0
        user_lessons.where(user: user).count/self.lessons.count.to_f*100
      end
    end

    def update_avaliacao
      if enrollments.any? && enrollments.where.not(avaliacao: nil).any?
        update_column :avaliacao_media, (enrollments.average(:avaliacao).round(2).to_f)
      else
        update_column :avaliacao_media, (0)
      end
    end
end
