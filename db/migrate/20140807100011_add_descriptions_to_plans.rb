class AddDescriptionsToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :descriptions, :text
  end
end
