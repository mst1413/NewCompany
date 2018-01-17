class CreateCompanyAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :company_admins do |t|
      t.string :username
      t.string :password
      t.string :email
      t.string :companyname

      t.timestamps
    end
  end
end
