class Project < ApplicationRecord
    belongs_to :company_admin
    has_many :employeesproject
    
end
