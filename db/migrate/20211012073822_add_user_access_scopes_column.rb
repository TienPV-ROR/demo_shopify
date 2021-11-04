class AddUserAccessScopesColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :access_scopes, :string
  end
end
