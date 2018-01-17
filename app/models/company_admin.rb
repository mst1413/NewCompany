class CompanyAdmin < ApplicationRecord
    validates :username, presence: true
    validates :password, presence: true
    validates :email, presence: true
    validates :companyname, presence: true
end
