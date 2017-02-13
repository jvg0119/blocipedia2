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
      all_wikis = scope.all
      if user.try(:admin?)
        # all_wikis.each do |wiki| 
        #   wikis << wiki
        wikis = scope.all
      elsif user.try(:premium?) 
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.user == user || wiki.wiki_collaborators.include?(user)
            wikis << wiki
          end
        end
      else
        all_wikis.each do |wiki| # standard & guests
          if !wiki.private? || wiki.wiki_collaborators.include?(user)
            wikis << wiki
          end
        end
      end # if user.try(:admin?)
      wikis
    end  # resolve
  end # scope
end

