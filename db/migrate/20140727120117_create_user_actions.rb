class CreateUserActions < ActiveRecord::Migration
  def change
    create_table :user_actions do |t|

      t.timestamps
    end
  end
end
