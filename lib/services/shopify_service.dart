import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/shopify_config.dart';
import '../models/order.dart';

class ShopifyService {
  // Fetch orders for a delivery partner
  Future<List<Order>> fetchOrders() async {
    try {
      final queryParams = {
        'status': 'any',
        'limit': '50',
        'fields': [
          'id',
          'name',
          'order_number',
          'created_at',
          'total_price',
          'subtotal_price',
          'total_tax',
          'financial_status',
          'fulfillment_status',
          'customer',
          'shipping_address',
          'billing_address',
          'phone',
          'contact_email',
          'note',
          'receipt_number',
          'line_items'
        ].join(',')
      };
      
      print('Fetching orders...');
      final uri = Uri.parse(ShopifyConfig.ordersEndpoint).replace(queryParameters: queryParams);
      
      final response = await http.get(
        uri,
        headers: ShopifyConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Response received. Status: ${response.statusCode}');
        
        if (data['orders'] == null) {
          print('No orders found in response');
          return [];
        }

        final orders = (data['orders'] as List).map((order) {
          print('\nProcessing order #${order['order_number']}:');
          print('Customer: ${order['customer']}');
          print('Shipping: ${order['shipping_address']}');
          print('Financial status: ${order['financial_status']}');
          print('Fulfillment status: ${order['fulfillment_status']}');
          
          return Order.fromJson(order);
        }).toList();

        print('Successfully processed ${orders.length} orders');
        return orders;
      } else {
        print('Error response: ${response.body}');
        throw Exception('Failed to load orders: ${response.statusCode}\nResponse: ${response.body}');
      }
    } catch (e) {
      print('Error fetching orders: $e');
      throw Exception('Error fetching orders: $e');
    }
  }

  // Fetch orders by pincode
  Future<List<Order>> fetchOrdersByPincode(String pincode) async {
    try {
      // Add query parameter for pincode filtering
      final endpoint = '${ShopifyConfig.ordersEndpoint}?shipping_address.zip=$pincode';
      
      final response = await http.get(
        Uri.parse(endpoint),
        headers: ShopifyConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final orders = (data['orders'] as List)
            .map((order) => Order.fromJson(order))
            .toList();
        return orders;
      } else {
        throw Exception('Failed to load orders for pincode $pincode: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching orders by pincode: $e');
    }
  }

  // Update order status
  Future<bool> updateOrderStatus(String orderId, String status) async {
    try {
      final endpoint = '${ShopifyConfig.ordersEndpoint}/$orderId.json';
      
      final response = await http.put(
        Uri.parse(endpoint),
        headers: ShopifyConfig.headers,
        body: json.encode({
          'order': {
            'id': orderId,
            'status': status,
          }
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error updating order status: $e');
    }
  }
} 