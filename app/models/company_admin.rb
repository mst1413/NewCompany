class CompanyAdmin < ApplicationRecord
  has_many :projects
  has_many :employees
  
  attr_accessor :presence_password

  has_secure_password validations: false
  validates :password, presence: true , if: :presence_password 
  has_secure_token
  validates :username, presence: true , length: { maximum: 15 }, uniqueness: true
  validates_confirmation_of :password
  validates :companyname , presence: true
  validates :email, presence: true, length: { :maximum => 40 },uniqueness: true,
            format: /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i 
  
  has_attached_file :logo , styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment :logo , presence: true,
                        size:{ :in => 0..100.kilobytes },
                        content_type: { :content_type => "image/jpeg" }
    
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