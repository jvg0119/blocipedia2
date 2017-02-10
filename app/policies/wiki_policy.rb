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
      wikis = []
     # if user.role == 'admin'
     if user.try(:admin?)
        wikis = scope.all 

      elsif user.try(:premium?) 
        #scope.public_wikis | scope.where(private: true, user: user) # cannot use arrays
        all_wikis = scope.all 
        all_wikis.each do |wiki| 
          if !wiki.private? || wiki.user == user || wiki.wiki_collaborators.include?(user)
            wikis << wiki
          end
        end

      else
        all_wikis = scope.all
        wikis = [] 
        all_wikis.each do |wiki| 
          if !wiki.private? || wiki.wiki_collaborators.include?(user)
            wikis << wiki 
          end
        end
      end
      wikis
    end    
  end
end





