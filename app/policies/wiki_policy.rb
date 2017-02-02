class WikiPolicy < ApplicationPolicy

  def index?
    #false
    true
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    #false
    user.present?
  end

  def new?
    create?
  end

  def update?
    #false
    # user.present? && (record.user == user || user.admin?)
    user.present? 
  end

  def edit?
    update?
  end

  def destroy?
    #false
    update?
  end


  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
