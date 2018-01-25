class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.date :joining_date
      t.date :birthdate
      t.integer :company_admin_id

      t.timestamps
    end
  end
end
