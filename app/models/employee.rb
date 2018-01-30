class Employee < ApplicationRecord
  belongs_to :company_admin
  has_many :employees_projects
  has_many :projects , through: :employees_projects
  has_many :tasks , foreign_key: "assignee_id"
  
  
  validates :name , :joining_date , :birthdate , presence: true
  validate :over_twenty       

  private
  def over_twenty
    if birthdate.present?
      if birthdate > 20.years.ago
        errors.add( :base , " Employee age must be over twenty")
      end
    end
  end
end
