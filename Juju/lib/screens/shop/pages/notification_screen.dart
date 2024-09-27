import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          NotificationTile(
            title: "Order Shipped",
            subtitle: "Your order #1234 has been shipped!",
            icon: Icons.local_shipping,
            color: Colors.blue,
          ),
          NotificationTile(
            title: "Voucher Available",
            subtitle: "You've received a new voucher for 10% off!",
            icon: Icons.card_giftcard,
            color: Colors.red,
          ),
          NotificationTile(
            title: "New Arrival",
            subtitle: "Check out the latest products in our store.",
            icon: Icons.new_releases,
            color: Colors.purple,
          ),
          // Các thông báo khác
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const NotificationTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Handle notification tap if needed
      },
    );
  }
}
