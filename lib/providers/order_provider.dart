import 'package:flutter/foundation.dart';
import '../models/order.dart';
import '../services/shopify_service.dart';

class OrderProvider with ChangeNotifier {
  final ShopifyService _shopifyService = ShopifyService();
  List<Order> _orders = [];
  bool _isLoading = false;
  String? _error;
  double _totalCollected = 0;
  double _totalPending = 0;
  double _todaysTotalCollected = 0;
  double _todaysTotalPending = 0;

  // Getters
  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get error => _error;
  double get totalCollected => _todaysTotalCollected;
  double get totalPending => _todaysTotalPending;
  Map<String, List<Order>> get groupedOrders => Order.groupByDate(_orders);
  
  List<Order> get todaysOrders {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return _orders.where((order) {
      final orderDate = DateTime(
        order.createdAt.year,
        order.createdAt.month,
        order.createdAt.day,
      );
      return orderDate.isAtSameMomentAs(today);
    }).toList();
  }
  
  int get totalOrders => todaysOrders.length;
  int get completedOrders => todaysOrders.where((order) => order.status == 'completed').length;
  int get pendingOrders => todaysOrders.where((order) => order.status == 'pending').length;

  // Fetch orders
  Future<void> fetchOrders() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _orders = await _shopifyService.fetchOrders();
      _calculateTotals();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch orders by pincode
  Future<void> fetchOrdersByPincode(String pincode) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _orders = await _shopifyService.fetchOrdersByPincode(pincode);
      _calculateTotals();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update order status
  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      final success = await _shopifyService.updateOrderStatus(orderId, status);
      if (success) {
        final orderIndex = _orders.indexWhere((order) => order.id == orderId);
        if (orderIndex != -1) {
          // Create a new order with updated status
          final updatedOrder = Order(
            id: _orders[orderIndex].id,
            orderNumber: _orders[orderIndex].orderNumber,
            customerName: _orders[orderIndex].customerName,
            address: _orders[orderIndex].address,
            pincode: _orders[orderIndex].pincode,
            totalAmount: _orders[orderIndex].totalAmount,
            subtotalAmount: _orders[orderIndex].subtotalAmount,
            taxAmount: _orders[orderIndex].taxAmount,
            isPaid: _orders[orderIndex].isPaid,
            createdAt: _orders[orderIndex].createdAt,
            deliveryDate: _orders[orderIndex].deliveryDate,
            status: status,
            receiptNumber: _orders[orderIndex].receiptNumber,
            customerPhone: _orders[orderIndex].customerPhone,
            customerEmail: _orders[orderIndex].customerEmail,
            customerNote: _orders[orderIndex].customerNote,
            isFulfilled: status == 'fulfilled',
            lineItems: _orders[orderIndex].lineItems,
          );
          
          // Update the orders list
          _orders[orderIndex] = updatedOrder;
          _calculateTotals();
          notifyListeners();
        }
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Calculate totals
  void _calculateTotals() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Calculate totals for all orders
    _totalCollected = _orders
        .where((order) => order.isPaid)
        .fold(0, (sum, order) => sum + order.totalAmount);
    
    _totalPending = _orders
        .where((order) => !order.isPaid)
        .fold(0, (sum, order) => sum + order.totalAmount);

    // Calculate totals for today's orders only
    _todaysTotalCollected = _orders
        .where((order) {
          final orderDate = DateTime(
            order.createdAt.year,
            order.createdAt.month,
            order.createdAt.day,
          );
          return orderDate.isAtSameMomentAs(today) && order.isPaid;
        })
        .fold(0, (sum, order) => sum + order.totalAmount);
    
    _todaysTotalPending = _orders
        .where((order) {
          final orderDate = DateTime(
            order.createdAt.year,
            order.createdAt.month,
            order.createdAt.day,
          );
          return orderDate.isAtSameMomentAs(today) && !order.isPaid;
        })
        .fold(0, (sum, order) => sum + order.totalAmount);
  }
} 