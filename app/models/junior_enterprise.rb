class JuniorEnterprise < ActiveRecord::Base
	before_create { set_to_zero(:access) }
	after_create { set_to_false(:seal) }
	

  	belongs_to :user	 
	has_many :members
	has_many :messages

	validates :name, :presence => true
	validates :name, :uniqueness => true
	validates :description, :presence => true
	validates :city, :presence => true
	validates :state, :presence => true
	validates :course, :presence => true

  def set_to_zero(column)
    self[column] = 0 
  end	

  def set_to_false(column)
    self[column] = false
    self.save
  end

end
