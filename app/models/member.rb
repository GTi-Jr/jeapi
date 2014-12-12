class Member < ActiveRecord::Base
	validates :name, :presence => true
	validates :name, :uniqueness => true
	validates :email, :presence => true
	validates :email, :uniqueness => true
end
