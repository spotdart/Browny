class AddUserToTokens < ActiveRecord::Migration
  def change
    add_column :tokens, :user, :string
  end
end
