import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juju/util/const.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final bool displayText;

  const RatingBar({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.displayText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 22,
          decoration: BoxDecoration(
            color: Constants.demoTeal,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Icon(
                    Icons.star_rounded,
                    color: index < rating.floor()
                        ? const Color(0xFFFFEB0E)
                        : Colors.white,
                    size: 12,
                  ),
                );
              },
            ),
          ),
        ),
        if (displayText)
          Text(
            'Rating ${rating.toStringAsFixed(1)} (${_formatNumber(reviewCount)})',
            style: GoogleFonts.montserrat(
              fontSize: 9,
              fontWeight: FontWeight.w300,
            ),
          ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      double result = number / 1000;
      return '${result.toStringAsFixed(1)}k';
    }
    return number.toString();
  }
}
