import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // ⛔ Disables back button
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          automaticallyImplyLeading: false, // ⛔ Hides back button
          backgroundColor: const Color(0xFF0051BA),
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/delivery_partner_logo.png', height: 28),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.language, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            // 🔍 Summary Section
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Order summary', style: TextStyle(fontWeight: FontWeight.w600)),
                      Text('Amount Collected', style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('02 April, 2025'),
                      Text('2500/5600', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildSummaryCard('25', 'Total orders', Colors.blue.shade100),
                      _buildSummaryCard('25', 'Completed', Colors.green.shade100),
                      _buildSummaryCard('25', 'Pending', Colors.red.shade100),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 📦 Summary Card Component
  static Widget _buildSummaryCard(String count, String label, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
