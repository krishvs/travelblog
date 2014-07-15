class CreateRoutesRoutes < ActiveRecord::Migration
  def change
    create_table :routes_routes do |t|
      t.belongs_to :route, index: true
      t.belongs_to :route, index: true
    end
  end
end
