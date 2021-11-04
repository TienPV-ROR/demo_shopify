class OrdersCreateJob < ActiveJob::Base
  def perform(shop_domain, webhook)
    shop = Shop.find_by(shopify_domain: shop_domain)

    if shop.nil?
      logger.error("#{self.class} failed: cannot find shop with domain '#{shop_domain}'")
      return
    end

    shop.with_shopify_session do
      Order.create(shopify_order_id: webhook["id"], total_price: webhook["current_total_price_set"]["shop_money"]["amount"])
    end
  end
end
