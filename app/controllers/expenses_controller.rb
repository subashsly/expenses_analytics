class ExpensesController < ApplicationController
   

  def index
    @expenses = current_member.expenses
    @expense_category = []
        Expense.select('category_id, sum(amount) as total').group('category_id').order('total desc').where(member_id: current_member.id).each do |expense| 
           category = Category.find(expense.category_id) 
          @expense_category.push([category.title.to_s,expense.total.to_i])
    end
    @e = [["subash",4]]
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
    # if params[:category_id].nil?
    #   @cat=Category.where("title = 'untagged'")
    #   print @cat.id
    #   print "haha"
    #    if (@cat.title =="")
    #     @category = Category.create(member_id: current_member.id, title: "untagged")
    #   end
    #     @expense = Expense.create(expense_params.merge(member_id: current_member.id, category_id: @category.id))
    # else
    #    @expense = Expense.create(expense_params.merge(member_id: current_member.id))
    # end



  	
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
