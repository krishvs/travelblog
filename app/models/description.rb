class Description < ActiveRecord::Base
  belongs_to :folder
  belongs_to :user
  
  include PublicActivity::Model
end
