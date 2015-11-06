class AddExpirationToItems < ActiveRecord::Migration
  def change
    add_column :items, :expiration, :datetime
  end
end
