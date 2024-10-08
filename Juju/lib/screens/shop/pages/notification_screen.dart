import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF9F3),
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xffF8D8B8),
      ),
      body: ListView(
        children: const [
          NotificationTile(
            title: "Order Shipped",
            subtitle: "Your order #1234 has been shipped!",
            icon: Icons.local_shipping,
            color: Color(0xff18AFBA),
          ),
          NotificationTile(
            title: "Voucher Available",
            subtitle: "You've received a new voucher for 10% off!",
            icon: Icons.card_giftcard,
            color: Color(0xffEF7168),
          ),
          NotificationTile(
            title: "New Arrival",
            subtitle: "Check out the latest products in our store.",
            icon: Icons.new_releases,
            color: Color.fromARGB(255, 203, 94, 222),
          ),
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

  const NotificationTile({super.key, 
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
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
      },
    );
  }
}
