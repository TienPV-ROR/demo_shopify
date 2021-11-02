class CreateOrders < ActiveRecord::Migration[6.1]
  def self.up
    create_table :orders do |t|
      t.string :shopify_order_id
      t.string :total_price
      t.timestamps
    end

  end
end
