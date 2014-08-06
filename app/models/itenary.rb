class Itenary < ActiveRecord::Base
	belongs_to :user
	belongs_to :folder
	has_many :plans
end
