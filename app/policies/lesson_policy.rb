class LessonPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  
    def show?
      @user.has_role?(:admin) || @record.course.user_id == @user.id || @record.course.inscritos(@user) == false
    end

    def edit?
      @record.course.user_id == @user.id
    end
  
    def update?
      @record.course.user_id == @user.id
    end
  
    def new?
      #@user.has_role?:professor
    end
  
    def create?
      @record.course.user_id == @user.id
    end
  
    def destroy?
      if @user
        @record.course.user_id == @user.id
      end
    end
  end
  