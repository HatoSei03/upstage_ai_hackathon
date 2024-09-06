import 'package:flutter/material.dart';
import 'package:juju/util/coupon.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juju/util/const.dart';
import 'package:juju/screens/question_screen.dart';
import 'package:juju/screens/chatbot.dart';

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
          style: TextStyle(
            color: Constants.lightText,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Constants.lightText,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Constants.header,
      ),
      body: ListView.builder(
        itemCount: listCoupon.length,
        itemBuilder: (context, index) {
          return ListTile(
            hoverColor: Constants.header,
            title: Text(
              listCoupon[index].name,
              style: GoogleFonts.roboto(
                color: Constants.darkText,
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
        backgroundColor: Constants.header,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 2.0,
        child: Icon(
          Icons.question_answer,
          color: Constants.lightText2,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
