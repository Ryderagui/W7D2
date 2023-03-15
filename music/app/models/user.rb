# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :email, :session_token, :password_digest, presence: true
    validates :email, uniqueness: true
    validates :password, length: {minimum: 6, allow_nil: true}
    attr_reader :password
    before_validation :ensure_session_token

    def self.find_by_credentials(email,password)
        user = User.find_by(email: email)
        
        if user && user.is_password?(password)
            return user 
        else 
            return nil 
        end
    
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        bcrypt_object = BCrypt::Password.new(self.password_digest)
        bcrypt_object.is_password?(password)
    end

    def reset_session_token!
        self.session_token = generate_session_token
        self.save!
        self.session_token
    end

    def generate_session_token
        token = SecureRandom.urlsafe_base64

        while User.exists?(session_token: token)
            token = SecureRandom.urlsafe_base64
        end

        token

    end

    def ensure_session_token
        self.session_token ||= generate_session_token
    end

end
