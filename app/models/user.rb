class User < ActiveRecord::Base
    has_many :jobs
    has_many :schedules
    has_many :memberships
    has_many :groups, :through => :memberships

	validates :username, :presence => true
	validates :password, :confirmation => true
	attr_accessor :password
	before_save :encrypt_password

	def encrypt_password
		if password
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

	def admin?
		self.administrator
	end

	def belongs_to? group
		group.users.include? self
	end

	def display
		self.name
	end

    def internal
        self.password_hash != nil
    end
end
