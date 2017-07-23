class IncomesController < ApplicationController
		


	def index
		@incomes = current_member.incomes.paginate(:page => 1, :per_page => 5)
		  @income_category = []
        Income.select('category_id, sum(amount) as total').group('category_id').order('total desc').each do |income| 
           category = Category.find(income.category_id) 
          @income_category.push([category.title.to_s,income.total.to_i])
    end
         
		
	end

	def show
		@income = Income.find(params[:id])
		
	end

	def new
		@income = Income.new
	end

	def create
		@incomes = current_member.incomes
		@income = Income.create(income_params.merge(member_id: current_member.id))
	end

	def edit
		@income = Income.find(params[:id])
	end

	def update
		@incomes = current_member.incomes 
		@income = Income.find(params[:id])

		@income.update_attributes(income_params)
	end

	def delete
		
		@income = Income.find(params[:income_id])
	end

	def destroy
		@income = Income.find(params[:id])
		@income.destroy
	end

	private
		def income_params
			params.require(:income).permit(:title, :description, :amount, :date, :member_id, :category_id)
		end
end
