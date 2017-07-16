class AddIndexToMembersMemberEmail < ActiveRecord::Migration
  def change
  	add_index :members, :member_email, unique: true
  end
end
