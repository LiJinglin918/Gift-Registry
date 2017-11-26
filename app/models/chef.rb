class Chef<ApplicationRecord
    attr_accessor :remember_token, :activation_token, :reset_token
    before_save   :downcase_email
   # before_save {self.email=email.downcase}
    validates :chefname,presence:true,length:{maximum:30}
    VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,presence:true,length:{maximum:245},
    format: {with:VALID_EMAIL_REGEX},
    uniqueness:{case_sensitive:false}
    
    has_many :recipes, dependent: :destroy
    has_secure_password
    validates :password, presence:true, length: {minimum: 5}, allow_nil: true

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Chef.exists?(column => self[column])
  end
  
  def Chef.new_token
    SecureRandom.urlsafe_base64
  end

  # Sets the password reset attributes.
  def create_reset_digest
  #  self.reset_token = Chef.new_token
   # update_attribute(:reset_digest,  Chef.digest(reset_token))
    #update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

end
