class Rider < ActiveRecord::Base
  
  require 'digest/sha1'
  
  has_many :comments

  # validate :password_non_blank

  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    create_new_salt
    self.hashed_password = Rider.encrypted_password(self.password, self.salt)
  end
    
  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end
    
  # should be private
  def self.encrypted_password(password, salt)
    string_to_hash = password + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  # should be private
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  # private 
  #  
  #  def password_non_blank
  #    errors.add(:password, "Missing password" ) if hashed_password.blank?
  #  end    
  
end
