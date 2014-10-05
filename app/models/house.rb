class House < ActiveRecord::Base
	has_many :volunteers
	has_many :residents
end
