class Course < ApplicationRecord
    validates :titulo, :linguagens , :nivel,  presence: true
    validates :descricao, presence: true, length: { :minimum => 5 }
    
    belongs_to :user
    has_many :lessons, dependent: :destroy
    has_many :enrollments

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
end
