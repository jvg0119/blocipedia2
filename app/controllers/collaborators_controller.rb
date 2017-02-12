class CollaboratorsController < ApplicationController
	before_action :set_user, only: [:create]
	before_action :set_wiki

	def index
		# @wiki = Wiki.find(params[:wiki_id])
		#@user_collaborators = @wiki.collaborators # OK 
		@wiki_collaborators = @wiki.wiki_collaborators
		@users = User.all
	end

	def create
		#raise
		# user = User.find(params[:user_id])
		# wiki = Wiki.find(params[:wiki_id])
		collaborator = @wiki.collaborators.new(user: @user)
		if collaborator.save!
			flash[:notice] = "Added collaborator"
			redirect_to wiki_collaborators_path(@wiki) 
		else
			flash[:error] = "Collaborator was not saved. Please try again."
			redirect_to wiki_collaborators_path(@wiki) 
		end
	end

	def destroy
		#user = User.find(params[:id])
		# wiki = Wiki.find(params[:wiki_id])
		#collaborator = wiki.collaborators.find_by(params[id: user.id]) # this needs the user above
		collaborator = @wiki.collaborators.find_by(params[:user_id])
		#raise
		if collaborator.destroy
			flash[:notice] = 'Removed collaborator'
			redirect_to wiki_collaborators_path(@wiki)
		else
			flash[:error] = "Collaborator was not removed. Please try again."
			redirect_to wiki_collaborators_path(@wiki)  
		end
	end

	private
	def set_user
		@user = User.find(params[:user_id])
	end

	def set_wiki
		@wiki = Wiki.find(params[:wiki_id])
	end

end
