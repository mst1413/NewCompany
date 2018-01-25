class ChangePasswordTopasswordDigest < ActiveRecord::Migration[5.1]
  def up
    rename_column :company_admins , :password , :password_digest
  end

  def down
    rename_column :company_admins ,  :password_digest , :password
  end
end
