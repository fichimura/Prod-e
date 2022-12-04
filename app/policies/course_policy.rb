class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    if @user
      @user.has_role?(:admin) || @record.user_id == @user.id
    end
  end

  def update?
    @user.has_role?(:admin) || @record.user_id == @user.id
  end

  def new?
    @user.has_role?:professor
  end

  def create?
    @user.has_role?:professor
  end

  def destroy?
    if @user
      @user.has_role?(:admin) || @record.user_id == @user.id
    end
  end

  def owner?
    @record.user == @user
  end
end
