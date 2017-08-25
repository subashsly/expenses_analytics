class Category < ActiveRecord::Base
	belongs_to :member
	has_many :incomes, dependent: :destroy
	has_many :expenses, dependent: :destroy
validates :title, uniqueness: {scope: :member_id}
	validates :title, presence: true
	validates :member_id, presence: true
	# validates :description, presence: true
	# validates :amount, presence: true
	# validates :date, presence: true
	
  # def self.total_on(date)
  # 	where("date(date) = ?", date).sum(:amount)
  # end
end
