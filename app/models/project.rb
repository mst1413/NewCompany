class Project < ApplicationRecord
    belongs_to :company_admin
    has_many :employees_projects
    has_many :tasks
    has_many :employees , through: :employees_projects     
end
