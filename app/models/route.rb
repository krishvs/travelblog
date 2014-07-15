class Route < ActiveRecord::Base
  belongs_to :folder
  has_and_belongs_to_many :routes
end
