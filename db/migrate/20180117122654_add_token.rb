class AddToken < ActiveRecord::Migration[5]
  def up
    add_column :company_admins , :token , :string
  end

  def down
    remove_column :company_admins , :token
  end
end
