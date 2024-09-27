import 'package:flutter/material.dart';
import 'package:juju/model/coupon.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juju/util/const.dart';
import 'package:juju/screens/question_screen.dart';
import 'package:juju/widgets/chatbot_float_button.dart';
import 'package:get/get.dart';

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
          icon: Icon(
            Icons.arrow_back,
            color: Constants.lightText,
          ),
          onPressed: () {
            Get.back();
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
              Get.to(
                () => QuestionScreen(
                  listquestion: listCoupon[index].listQuestion,
                ),
                transition: Transition.zoom,
              );
            },
          );
        },
      ),
      floatingActionButton: const ChatbotFloatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
