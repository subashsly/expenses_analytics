class AddAgreedToTermsToMembers < ActiveRecord::Migration
  def change
    add_column :members, :agreed_to_terms, :datetime
  end
end
