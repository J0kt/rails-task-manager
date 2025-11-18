# db/migrate/20251118XXXXXX_drop_restaurants_table.rb (The file you just created)

class DropRestaurantsTable < ActiveRecord::Migration[7.1]
  def change
    # This command drops the table. Rails knows how to reverse this (create_table).
    drop_table :restaurants
  end
end
