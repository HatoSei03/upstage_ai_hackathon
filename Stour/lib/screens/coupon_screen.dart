import 'package:flutter/material.dart';
import 'package:stour/util/coupon.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stour/util/const.dart';
import 'package:stour/screens/question_screen.dart';
import 'package:stour/screens/chatbot.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({super.key});
  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coupons',
          style: GoogleFonts.roboto(
            color: const Color.fromARGB(255, 35, 52, 10),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 35, 52, 10)), // Change the color here
          onPressed: () {
            // Handle back button logic
            Navigator.pop(context);
          },
        ),
        backgroundColor: Constants.palette3,
      ),
      body: ListView.builder(
        itemCount: listCoupon.length,
        itemBuilder: (context, index) {
          return ListTile(
            hoverColor: Constants.lightpp,
            title: Text(
              listCoupon[index].name,
              style: GoogleFonts.roboto(
                color: Constants.text,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle:
                Text('Apply to all locations', style: GoogleFonts.roboto()),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return QuestionScreen(
                        listquestion: listCoupon[index].listQuestion);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatbotSupportScreen(),
            ),
          );
        },
        tooltip: 'Floating Action Button',
        backgroundColor: Constants.palette3, // Custom color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Round shape
        ),
        elevation: 2.0,
        child: const Icon(Icons.question_answer),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
