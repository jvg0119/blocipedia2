class CollaboratorsController < ApplicationController

	def index
		#@wiki_collaborators = Collaborator.all
		@wiki = Wiki.find(params[:wiki_id])
		@user_collaborators = @wiki.collaborators
		@users = User.all
		#@user_collaborators = Collaborator.all
	end


	def edit

	end

	def update
	end


	def new
	end

	def create
		#raise
		user = User.find(params[:user_id])
		wiki = Wiki.find(params[:wiki_id])
		collaborator = wiki.collaborators.new(user_id: user.id)
		if collaborator.save
			flash[:notice] = "added"
			redirect_to wiki_collaborators_path(wiki) 
		else
			flash[:notice] = "did not save collaborator"
			redirect_to wiki_collaborators_path(wiki) 
		end
	end

	def destroy
		user = User.find(params[:id])
		wiki = Wiki.find(params[:wiki_id])
		#collaborator = Collaborator.find(params[:id])
		collaborator = wiki.collaborators.find_by(params[id: user.id])
		#raise
		if collaborator.destroy
			flash[:notice] = 'removed'
			redirect_to wiki_collaborators_path(wiki) 
		end
	end


end
