class AddPriceToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :price_cent, :decimal
  end
end
