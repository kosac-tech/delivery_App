class Order {
  final String id;
  final String orderNumber;
  final String customerName;
  final String address;
  final String pincode;
  final double totalAmount;
  final double subtotalAmount;
  final double taxAmount;
  final bool isPaid;
  final DateTime createdAt;
  final DateTime? deliveryDate;
  final String status;
  final String receiptNumber;
  final String? customerPhone;
  final String? customerEmail;
  final String? customerNote;
  final bool isFulfilled;
  final List<Map<String, dynamic>> lineItems;

  Order({
    required this.id,
    required this.orderNumber,
    required this.customerName,
    required this.address,
    required this.pincode,
    required this.totalAmount,
    required this.subtotalAmount,
    required this.taxAmount,
    required this.isPaid,
    required this.createdAt,
    this.deliveryDate,
    required this.status,
    required this.receiptNumber,
    this.customerPhone,
    this.customerEmail,
    this.customerNote,
    required this.isFulfilled,
    required this.lineItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    try {
      // Get customer info
      final customer = json['customer'] as Map<String, dynamic>? ?? {};
      final shippingAddress = json['shipping_address'] as Map<String, dynamic>? ?? {};
      final billingAddress = json['billing_address'] as Map<String, dynamic>? ?? {};

      // Get customer name with fallbacks
      String customerName = '';
      
      // Try customer object first
      if (customer['first_name'] != null || customer['last_name'] != null) {
        customerName = '${customer['first_name'] ?? ''} ${customer['last_name'] ?? ''}'.trim();
      }
      // Then try shipping address
      else if (shippingAddress['first_name'] != null || shippingAddress['last_name'] != null) {
        customerName = '${shippingAddress['first_name'] ?? ''} ${shippingAddress['last_name'] ?? ''}'.trim();
      }
      // Then try billing address
      else if (billingAddress['first_name'] != null || billingAddress['last_name'] != null) {
        customerName = '${billingAddress['first_name'] ?? ''} ${billingAddress['last_name'] ?? ''}'.trim();
      }
      // Finally, try email or order name
      else {
        customerName = customer['email'] ?? json['name']?.toString() ?? 'Unknown Customer';
      }

      // Get address (prefer shipping, fallback to billing)
      final addressToUse = shippingAddress.isNotEmpty ? shippingAddress : billingAddress;
      
      final List<String> addressParts = [];
      
      // Add company if available
      if (addressToUse['company']?.toString().isNotEmpty ?? false) {
        addressParts.add(addressToUse['company']);
      }
      
      // Add address lines
      if (addressToUse['address1']?.toString().isNotEmpty ?? false) {
        addressParts.add(addressToUse['address1']);
      }
      if (addressToUse['address2']?.toString().isNotEmpty ?? false) {
        addressParts.add(addressToUse['address2']);
      }
      
      // Add city, province, country
      final List<String> locationParts = [];
      if (addressToUse['city']?.toString().isNotEmpty ?? false) {
        locationParts.add(addressToUse['city']);
      }
      if (addressToUse['province']?.toString().isNotEmpty ?? false) {
        locationParts.add(addressToUse['province']);
      }
      if (addressToUse['country']?.toString().isNotEmpty ?? false) {
        locationParts.add(addressToUse['country']);
      }
      
      if (locationParts.isNotEmpty) {
        addressParts.add(locationParts.join(', '));
      }

      final address = addressParts.join('\n');
      
      // Get contact information
      final customerPhone = customer['phone'] ?? 
                          shippingAddress['phone'] ?? 
                          billingAddress['phone'] ?? 
                          json['phone']?.toString();
                          
      final customerEmail = customer['email'] ?? 
                          json['contact_email']?.toString();

      // Parse amounts
      final totalAmount = double.tryParse(json['total_price']?.toString() ?? '0') ?? 0.0;
      final subtotalAmount = double.tryParse(json['subtotal_price']?.toString() ?? '0') ?? 0.0;
      final taxAmount = double.tryParse(json['total_tax']?.toString() ?? '0') ?? 0.0;

      // Get receipt number
      final receiptNumber = json['receipt_number']?.toString() ?? '';

      // Get line items
      final lineItems = (json['line_items'] as List?)?.map((item) => item as Map<String, dynamic>).toList() ?? [];

      return Order(
        id: json['id']?.toString() ?? '',
        orderNumber: json['order_number']?.toString() ?? json['name']?.toString() ?? '',
        customerName: customerName,
        address: address,
        pincode: addressToUse['zip']?.toString() ?? addressToUse['postal_code']?.toString() ?? '',
        totalAmount: totalAmount,
        subtotalAmount: subtotalAmount,
        taxAmount: taxAmount,
        isPaid: (json['financial_status']?.toString()?.toLowerCase() ?? '') == 'paid',
        createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
        deliveryDate: json['delivery_date'] != null ? DateTime.parse(json['delivery_date']) : null,
        status: json['fulfillment_status']?.toString()?.toLowerCase() ?? 'pending',
        receiptNumber: receiptNumber,
        customerPhone: customerPhone,
        customerEmail: customerEmail,
        customerNote: json['note']?.toString(),
        isFulfilled: json['fulfillment_status']?.toString()?.toLowerCase() == 'fulfilled',
        lineItems: lineItems,
      );
    } catch (e) {
      print('Error parsing order: $e');
      print('Order JSON: $json');
      rethrow;
    }
  }

  // Helper method to group orders by date
  static Map<String, List<Order>> groupByDate(List<Order> orders) {
    final Map<String, List<Order>> grouped = {};
    
    for (var order in orders) {
      final date = _formatDate(order.createdAt);
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(order);
    }
    
    return grouped;
  }

  // Format date for grouping
  static String _formatDate(DateTime date) {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final orderDate = DateTime(date.year, date.month, date.day);

    if (orderDate == DateTime(now.year, now.month, now.day)) {
      return 'Today';
    } else if (orderDate == yesterday) {
      return 'Yesterday';
    } else {
      return '${date.day} ${_getMonth(date.month)}, ${date.year}';
    }
  }

  static String _getMonth(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
} 