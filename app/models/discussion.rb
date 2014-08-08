class Discussion < ActiveRecord::Base	
	belongs_to :discussable, polymorphic: true
	acts_as_commentable
end
