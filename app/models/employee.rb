class Employee < ApplicationRecord
    belongs_to :company_admin
    has_many :employeesproject
    
end
