require 'test_helper'

class IncomeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@member = members(:bibek)
  	@income = @member.incomes.build(title: "First Salary", description: "This is first salary.",
  																	amount: 1200, date: Time.now)
  end

  test "income should be valid" do 
  	assert @income.valid?
  end

  test "member id should be present" do
  	@income.member_id = nil
  	assert_not @income.valid?
  end

  test "title should be present" do 
  	@income.title = " "
  	assert_not @income.valid?
  end

  test "title should not be more than 200 charancters" do 
  	@income.title = 'a' * 201
  	assert_not @income.valid?
  end

  test "description should be present" do 
  	@income.description = nil
  	assert_not @income.valid?
  end

  test "amount should be present" do 
  	@income.amount = nil
  	assert_not @income.valid?
  end

  test "date should be present" do 
  	@income.date = nil
  	assert_not @income.valid?
  end
end
