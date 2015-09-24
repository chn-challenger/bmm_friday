require 'bcrypt'

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, required: true, unique: true
  property :password_digest, Text

  attr_reader :password
  attr_reader :email
  attr_accessor :password_confirmation

  validates_confirmation_of :password

  #as email includes required: true the code below becomes unnecessary
  validates_presence_of :email


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
  end

end
