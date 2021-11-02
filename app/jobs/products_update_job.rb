class ProductsUpdateJob < ActiveJob::Base
  def perform(shop_domain, webhook)
    shop = Shop.find_by(shopify_domain: shop_domain)

    if shop.nil?
      logger.error("#{self.class} failed: cannot find shop with domain '#{shop_domain}'")
      return
    end

    shop.with_shopify_session do
      product = Product.find_by(shopify_product_id: webhook["id"])
      if product.present? 
        product.update(title: webhook["title"])
      end
    end
  end
end
