class Description < ActiveRecord::Base
  belongs_to :folder
  include PublicActivity::Model
end
