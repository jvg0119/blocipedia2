class WikisController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create]
	before_action :set_wiki, only: [:show, :edit, :update, :destroy]

  def index
  	#@wikis = Wiki.all.paginate(page: params[:page], per_page: 10)
    #@wikis = policy_scope(Wiki).paginate(page: params[:page], per_page: 10)
    #@public_wikis = policy_scope(Wiki.where(private: false)).paginate(page: params[:page], per_page: 10)
    @public_wikis = policy_scope(Wiki.public_wikis).paginate(page: params[:page], per_page: 10)
    #@private_wikis = policy_scope(Wiki.where(private: true)).paginate(page: params[:page], per_page: 10)
    @private_wikis = policy_scope(Wiki.private_wikis).paginate(page: params[:page], per_page: 10)
  #  authorize @wikis
  end

  def show
    authorize @wiki
  end

  def new
  	@wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.new(wiki_params)
    authorize @wiki
  	if @wiki.save 
  		flash[:notice] = "Your wiki was saved successfully!"
  		redirect_to @wiki 
  	else
  		flash[:error] = "There was an error saving your wiki. Please try again."
  		render :new
  	end
  end

  def edit
    authorize @wiki
   # @users = User.all
  end

  def update
    authorize @wiki
  	if @wiki.update_attributes(wiki_params)
  		flash[:notice] = "Your wiki was updated successfully!"
  		redirect_to @wiki 
  	else
  		flash[:error] = "There was an error updatting your wiki. Please try again."
  		render :edit
  	end
  end

  def destroy
    authorize @wiki
    #raise
  	@wiki.destroy
 		flash[:notice] = "Deleted wiki."
  	redirect_to wikis_path   	
  end

private 
	def wiki_params 
		params.require(:wiki).permit(:title, :content, :body, :private)
	end

	def set_wiki
		@wiki = Wiki.find(params[:id])
	end
   
end



