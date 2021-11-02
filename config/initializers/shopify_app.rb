ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.old_secret = ""
  config.scope = "read_customers, read_orders, write_products, read_products" # Consult this page for more scope options:
                                  # https://help.shopify.com/en/api/getting-started/authentication/oauth/scopes
  config.embedded_app = true
  config.after_authenticate_job = false
  config.api_version = "2021-10"
  config.shop_session_repository = 'Shop'

  config.reauth_on_access_scope_changes = true

  config.allow_jwt_authentication = true
  config.allow_cookie_authentication = false

  config.api_key = ENV.fetch('SHOPIFY_API_KEY', '').presence
  config.secret = ENV.fetch('SHOPIFY_API_SECRET', '').presence
  if defined? Rails::Server
    raise('Missing SHOPIFY_API_KEY. See https://github.com/Shopify/shopify_app#requirements') unless config.api_key
    raise('Missing SHOPIFY_API_SECRET. See https://github.com/Shopify/shopify_app#requirements') unless config.secret
    config.webhooks = [
      {topic: 'orders/create', address: 'https://bfd9-123-24-142-77.ngrok.io/webhooks/orders_create', format: 'json'},
      {topic: 'products/create', address: 'https://bfd9-123-24-142-77.ngrok.io/webhooks/products_create', format: 'json'},
      {topic: 'products/update', address: 'https://bfd9-123-24-142-77.ngrok.io/webhooks/products_update', format: 'json'}
    ]
    config.after_authenticate_job = { job: "Shopify::AfterAuthenticateJob", inline: false }
end
  config.webhooks = [
    {topic: 'orders/create', address: 'https://bfd9-123-24-142-77.ngrok.io/webhooks/orders_create', format: 'json'},
    {topic: 'products/create', address: 'https://bfd9-123-24-142-77.ngrok.io/webhooks/products_create', format: 'json'},
    {topic: 'products/update', address: 'https://bfd9-123-24-142-77.ngrok.io/webhooks/products_update', format: 'json'}
  ]
  config.after_authenticate_job = { job: "Shopify::AfterAuthenticateJob", inline: false }
end

# ShopifyApp::Utils.fetch_known_api_versions                        # Uncomment to fetch known api versions from shopify servers on boot
# ShopifyAPI::ApiVersion.version_lookup_mode = :raise_on_unknown    # Uncomment to raise an error if attempting to use an api version that was not previously known
