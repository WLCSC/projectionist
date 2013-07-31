class Command < ActiveRecord::Base
    has_many :installations
    has_many :screens, :through => :installations

    def display
        self.name
    end
end
