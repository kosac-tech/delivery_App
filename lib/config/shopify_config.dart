import 'package:flutter_dotenv/flutter_dotenv.dart';

class ShopifyConfig {
  // These will be initialized from environment variables
  static String get shopDomain => dotenv.env['SHOPIFY_SHOP_DOMAIN'] ?? '';
  static String get accessToken => dotenv.env['SHOPIFY_ACCESS_TOKEN'] ?? '';
  static const String apiVersion = '2024-01'; // Current API version

  // API endpoints
  static String get ordersEndpoint => 
    'https://$shopDomain/admin/api/$apiVersion/orders.json';
  
  static String get customersEndpoint =>
    'https://$shopDomain/admin/api/$apiVersion/customers.json';

  // Headers for API requests
  static Map<String, String> get headers => {
    'X-Shopify-Access-Token': accessToken,
    'Content-Type': 'application/json',
  };
} 