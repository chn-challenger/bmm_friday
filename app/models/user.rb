require 'bcrypt'

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :password_digest, Text

  attr_reader :password
  attr_reader :email
  attr_accessor :password_confirmation
  attr_accessor :email_confirmation

  validates_confirmation_of :password

  validates_confirmation_of :email

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end
