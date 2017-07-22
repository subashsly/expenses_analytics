class Reminder < ActiveRecord::Base
	belongs_to :member
	# belongs_to :category
	validates :title, presence: true
	validates :amount, presence: true, numericality: true
	validates :date_notify, presence: true
	validates :description, presence: true
end
