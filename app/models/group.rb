class Group < ActiveRecord::Base
	has_many :memberships, :dependent => :destroy
	has_many :users, :through => :memberships

    validates :name, :presence => true
    validates :auth_attribute, :presence => true
    validates :auth_value, :presence => true

	def display
		self.name
	end
end
