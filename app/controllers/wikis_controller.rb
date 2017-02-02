class WikisController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_wiki, only: [:show, :edit, :update, :destroy]

  def index
  	@wikis = Wiki.all
  end

  def show
  end

  def new
  	@wiki = Wiki.new
  end

  def create
  	@wiki = current_user.wikis.new(wiki_params)
  	if @wiki.save 
  		flash[:notice] = "Your wiki was saved successfully!"
  		redirect_to @wiki 
  	else
  		flash[:error] = "There was an error saving your wiki. Please try again."
  		render :new
  	end
  end

  def edit
  end

  def update
  	if @wiki.update_attributes(wiki_params)
  		flash[:notice] = "Your wiki was updated successfully!"
  		redirect_to @wiki 
  	else
  		flash[:error] = "There was an error updatting your wiki. Please try again."
  		render :edit
  	end
  end

  def destroy
  	@wiki.destroy
 		flash[:notice] = "Deleted wiki."
  	redirect_to wikis_path   	
  end

private 
	def wiki_params 
		params.require(:wiki).permit(:title, :content, :body)
	end

	def set_wiki
		@wiki = Wiki.find(params[:id])
	end
   
end



