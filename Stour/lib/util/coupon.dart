import 'package:stour/util/question.dart';

class Coupon {
  final int avaiable;
  final String couponId;
  final int discount;
  final String endDate;
  final String startDate;
  final String name;
  final List<Question> listQuestion;
  Coupon({
    required this.avaiable,
    required this.couponId,
    required this.discount,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.listQuestion,
  });
}

List<Coupon> listCoupon = [
  Coupon(
    avaiable: 3,
    couponId: 'couponId1',
    discount: 5,
    name: '5% Off',
    startDate: 'startDate',
    endDate: 'endDate',
    listQuestion: [
      Question(
          ques: 'Hallasan Mountain is the highest peak in South Korea?',
          answ: true),
      Question(
        ques: 'There are volcanic caves to explore in Jeju?',
        answ: true,
      ),
      Question(
          ques:
              'You can go on a submarine tour to see underwater volcanic formations?',
          answ: false),
    ],
  ),
  Coupon(
    avaiable: 100,
    couponId: 'couponId2',
    discount: 10,
    name: '10% Off On All Products',
    startDate: 'startDate',
    endDate: 'endDate',
    listQuestion: [
      Question(
          ques:
              'You can experience the local culture through traditional performances? ',
          answ: true),
      Question(
          ques: 'Seaweed is a common ingredient in Jeju cuisine ?', answ: true),
      Question(ques: 'Jeju has a traditional wedding ceremony ?', answ: true),
    ],
  ),
  Coupon(
    avaiable: 100,
    couponId: 'couponId3',
    discount: 10,
    name: '15% Off, Grab Em\' All',
    startDate: 'startDate',
    endDate: 'endDate',
    listQuestion: [
      Question(
          ques:
              'You can experience the local culture through traditional performances? ',
          answ: true),
      Question(
          ques: 'Seaweed is a common ingredient in Jeju cuisine ?', answ: true),
      Question(ques: 'Jeju has a traditional wedding ceremony ?', answ: true),
    ],
  ),
];
