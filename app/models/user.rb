class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  
  rolify
  

  has_many :enrollments
  has_many :courses
  
  def to_s
    email
  end

  def username
    self.email.split(/@/).first
  end

  extend FriendlyId
  friendly_id :email, use: :slugged


  after_create :assign_default_role

  def assign_default_role
    if User.count == 1
      self.add_role(:admin) if self.roles.blank?
      self.add_role(:professor)
      self.add_role(:estudante)
    else
      self.add_role(:estudante) if self.roles.blank?
      self.add_role(:professor) #if you want any user to be able to create own courses
    end
  end

  validate :must_have_a_role, on: :update

  def online?
    updated_at > 2.minutes.ago
  end

  def inscreveu(course)
    self.enrollments.create(course: course)
  end


  private
  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "O usuário deve ter pelo menos uma atribuição")
    end
  end


end
