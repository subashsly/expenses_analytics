class Contact < ActiveRecord::Base
  belongs_to :member
  validates :member_id, presence: true
  validates :name, presence: true
  validates :phone_no, presence: true
  validates :address, presence: true
end
