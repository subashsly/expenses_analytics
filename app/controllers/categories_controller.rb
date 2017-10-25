class CategoriesController < ApplicationController


	def index
		@categories = Category.where(member_id: current_member.id)
		respond_to do |format|
	      format.html # renders index.html.erb
	      format.js # renders index.js.erb
    	end
	end

	def new
		@category = Category.new
	end

	def create
		@categories = Category.all	
		@category = Category.create(category_params.merge(member_id: current_member.id))
		
	end

	def show
		@category = Category.find(params[:id])
		@category_data=(@category.expenses + @category.incomes).sort{|a,b| a.date <=> b.date }

	end

	def edit
		@category = Category.find(params[:id])
	end


	def delete
		@category = Category.find(params[:category_id])
	end

	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		# redirect_to categories_path
	end

	private 
  	def category_params
  		params.require(:category).permit(:title)
  	end

end
