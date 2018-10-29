class User < ActiveRecord::Base
    has_many :articles
    has_secure_password #Harry le met après validates email... plus joli là
    
    before_save {self.email.downcase!}
    
    validates :username, presence: true,
                         length: {minimum: 3, maximum: 20},
                         uniqueness: { case_sensitive: false }
                         
    VALID_EMAIL_REGEX = /.+\@.+\..+/i
    
    validates :email, presence: true,
                      uniqueness: { case_sensitive: false },
                      format: { with: VALID_EMAIL_REGEX }
end