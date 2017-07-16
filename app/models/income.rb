class Income < ActiveRecord::Base
  belongs_to :member
  # validates :member_id, presence: true
  validates :title, presence: true, length: { maximum: 200 }
  validates :description, presence: true
  validates :amount, presence: true
  validates :date, presence: true

  def self.total_on(date)
  	where("date(date) = ?", date).sum(:amount)
  end
 
end