class ExpensesController < ApplicationController
   

  def index
    @expenses = current_member.expenses
    respond_to do |format|
      format.html # renders index.html.erb
      format.js # renders index.js.erb
    end
  end

  def show
  	@expense = Expense.find(params[:id])
    # ajax for displaying expense on dashboard
    # respond_to do |format|
    #   format.html # renders show.html.erb
    #   format.js # renders show.js.erb
    # end
  end

  def new
  	@expense = Expense.new
  end

  def create
  	@expenses = current_member.expenses
  	@expense = Expense.create(expense_params.merge(member_id: current_member.id))
  end

  def edit
  	@expense = Expense.find(params[:id])
  end

  def update
  	@expenses = current_member.expenses
  	@expense = Expense.find(params[:id])

  	@expense.update_attributes(expense_params)
  end

  def delete
  	@expense = Expense.find(params[:expense_id])
     
  end

  def destroy
  	
  	@expense = Expense.find(params[:id])
     
  	@expense.destroy

  end


  private 
  	def expense_params
  		params.require(:expense).permit(:title, :description, :amount, :date, :category_id).merge(member_id: current_member.id)
  	end
    
end
