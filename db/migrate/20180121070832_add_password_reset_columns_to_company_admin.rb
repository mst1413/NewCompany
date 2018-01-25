class AddPasswordResetColumnsToCompanyAdmin < ActiveRecord::Migration[5.1]
  def up
    add_column :company_admins, :reset_password_token, :string
    add_column :company_admins, :reset_password_sent_at, :datetime
  end
  def down
    remove_column :company_admins , :reset_password_token
    remove_column :company_admins , :reset_password_sent_at
  end
end
