class Expense < ActiveRecord::Base
	belongs_to :member
	belongs_to :category

	validates :title, presence: true
	validates :description, presence: true
	validates :amount, presence: true
	validates :date, presence: true
	
  def self.total_on(date)
  	where("date(date) = ?", date).sum(:amount)
  end
end
