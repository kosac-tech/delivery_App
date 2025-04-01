import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F8FF), // 💙 Overall background
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0051BA), // Kosac blue
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/homescreen_delivery_logo.png',
              height: 28,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Text(
                'Logo missing',
                style: TextStyle(color: Colors.white),
              ),
            ),
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
      body: ListView(
        children: [
          _buildSummarySection(),
          _buildDateLabel("ORDERS - TODAY"),
          _buildOrderCard(
            id: "#2049",
            title: "Siddhivinayak Medical",
            address: "Sai Medical Ishana 1 society Vanaz, kothrud 411038 Pune India",
            paymentStatus: "Pending",
            isPaid: false,
            deliveryDate: "20 April, 2025",
          ),
          _buildOrderCard(
            id: "#2049",
            title: "Siddhivinayak Medical",
            address: "Sai Medical Ishana 1 society Vanaz, kothrud 411038 Pune India",
            paymentStatus: "Done",
            isPaid: true,
            deliveryDate: "20 April, 2025",
          ),
          _buildDateLabel("YESTERDAY"),
          _buildCompletedOrderCard(),
          _buildDateLabel("25, MARCH 2025"),
          _buildCompletedOrderCard(),
          _buildCompletedOrderCard(),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white, // 🤍 Card background
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
              _buildSummaryCard('25', 'Total orders', const Color(0xFFD4E5FF)),
              _buildSummaryCard('25', 'Completed', const Color(0xFFCFF3D8)),
              _buildSummaryCard('25', 'Pending', const Color(0xFFFFD6D6)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String count, String label, Color color) {
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

  Widget _buildDateLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            label.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard({
    required String id,
    required String title,
    required String address,
    required String paymentStatus,
    required bool isPaid,
    required String deliveryDate,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        color: Colors.white, // Card background
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  id,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0051BA)),
                ),
                const Text("🚚 Delivery"),
              ],
            ),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(address, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment: $paymentStatus",
                  style: TextStyle(color: isPaid ? const Color(0xFF00A652) : Colors.red),
                ),
                Text("Deliver on: $deliveryDate", style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedOrderCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "#2049",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Siddhivinayak Medical",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
            SizedBox(height: 2),
            Text(
              "Sai Medical Ishana 1 society Vanaz , kothrud 411038 Pune India",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Payment: Done", style: TextStyle(color: Colors.grey)),
                Text(
                  "ORDER COMPLETED",
                  style: TextStyle(color: Color(0xFF00A652), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
