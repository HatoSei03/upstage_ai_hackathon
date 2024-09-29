import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juju/screens/community/widget/profile_post.dart';
import 'package:juju/widgets/search_bar.dart';
import 'package:juju/screens/community/feeds/create_post.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int selectedFilterIndex = 0;
  final List<String> filters = [
    "Popular",
    "Most Recent",
    "Budget-friendly",
    "Rising-star"
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: SearchBarWidget(),
              ),

              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedFilterIndex == index;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(
                          filters[index],
                          style: GoogleFonts.montserrat(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xff6A778B),
                            fontSize: 14.0,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            selectedFilterIndex =
                                selected ? index : selectedFilterIndex;
                          });
                        },
                        selectedColor: const Color(0xffEF7168),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            color: isSelected
                                ? const Color(0xffEF7168)
                                : const Color(0xffD6D6D6),
                            width: 1,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              const PostScreen(),
            ],
          ),
        ),
        Positioned(
          bottom: -20,
          left: 40,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 36.0,
              bottom: 36.0,
            ),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => const CreatePostModal(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: GoogleFonts.rubik(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    backgroundColor: const Color(0xffEF7168),
                  ),
                  child: Text(
                    'Create a post',
                    style: GoogleFonts.rubik(
                      height: 0.95,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
