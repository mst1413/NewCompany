class CompanyAdmin < ApplicationRecord
  has_many :projects
  has_many :employees
  

  has_secure_password validations: false
  validates :password, presence: true
  has_secure_token
  
  validates_confirmation_of :password

  validates :username, presence: true
  validates :email, presence: true,
            format: /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i 
  validates :companyname, presence: true

  
    def with_unexpired_token(token, period)
      where(token: token).where('token_created_at >= ?', period).first
    end
    

    def generate_password_token!
      self.reset_password_token = generate_token
      self.reset_password_sent_at = Time.now.utc  #??
      save!
    end
    
    def password_token_valid?
      (self.reset_password_sent_at + 4.hours) > Time.now.utc
    end
    
    def reset_password!(password , password_confirmation)
      self.reset_password_token = nil
      update_attributes(password: password , password_confirmation: password_confirmation)
    end
    
    def send_recover_email
      CompanyAdminMailer.recover_password_email(self).deliver_later
    end
    
    private
    
    def generate_token
      SecureRandom.hex(10)

    end
  

    


    
      
end
