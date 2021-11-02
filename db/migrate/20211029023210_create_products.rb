class CreateProducts < ActiveRecord::Migration[6.1]
  def self.up
    create_table :products do |t|
      t.string :shopify_product_id
      t.string :title
      t.timestamps
    end

  end
end
