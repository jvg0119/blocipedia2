class WikiPolicy < ApplicationPolicy

  def index?
    #false
    true
  end

  def update?
    #false
    # user.present? && (record.user == user || user.admin?)
    user.present? 
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end


  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve

     if user.try(:admin?)
        wikis = scope.all
      elsif user.try(:premium?) 
         scope.public_wikis + scope.private_wikis.where(user: user) + user.wiki_collaborations
         # public wikis + private wikis owned by current_user + wikis the user is collaborating with

      elsif user.try(:standard?)
        scope.public_wikis + user.wiki_collaborations

      else
        scope.public_wikis # guest
      end  
    end   # resolve
  end   # scope
end


