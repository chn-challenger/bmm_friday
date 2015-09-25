require 'bcrypt'

module TheApp
  module Models
    class User
      include DataMapper::Resource
      property :id, Serial
      property :email, String, required: true, unique: true
      property :password_digest, Text
      property :password_token, Text
      attr_reader :password
      attr_reader :email
      attr_accessor :password_confirmation
      validates_confirmation_of :password
      validates_presence_of :email
      def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
      end
      def self.authenticate(email, password)
        user = User.first(email: email)
        if user && BCrypt::Password.new(user.password_digest) == password
          user
        else
          nil
        end
      end
    end
  end
end
