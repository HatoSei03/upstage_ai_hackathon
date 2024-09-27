import 'package:flutter/material.dart';
import 'package:juju/screens/trending.dart';
import 'package:juju/util/const.dart';
import 'package:juju/model/places.dart';
import 'package:juju/widgets/place_card.dart';
import 'package:juju/widgets/search_card.dart';
import 'package:juju/widgets/home_app_bar.dart';
import 'package:flutter/services.dart';
import 'package:juju/widgets/chatbot_float_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juju/widgets/swipeable_cards.dart';
import 'package:juju/widgets/search_bar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  List<String> placeTag = [
    "Popular",
    "City",
    "Beach",
    "Lake",
    "Mountain",
  ];
  List<String> foodTag = [
    "Popular",
    "Traditional",
    "Marketplace",
    "Street Food",
    "Fruits",
    "Snack",
    "Fine Dining",
    "Seafood"
  ];

  int selectedFilterPlace = 0;
  int selectedFilterFood = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Constants.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppBar(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi JUJU,',
                        style: GoogleFonts.rubik(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          color: const Color(0xff39414B),
                        ),
                      ),
                      Text(
                        "Wonderful JEJU",
                        style: GoogleFonts.rubik(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xff121212),
                        ),
                      ),
                      Text(
                        "Let's Explore Together",
                        style: GoogleFonts.rubik(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff6F7789),
                            height: 0.9),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SwipeableCards([
                  SwipableCard(
                    "https://api.cdn.visitjeju.net/photomng/imgpath/201804/30/93ae6602-1f2f-4b09-8ba2-0c1ea0dc815b.jpg",
                    "Jeju Fire Festival",
                    "Bongseong, Jeju Island, South Korea",
                    "Usually held in February or March",
                    "A spectacular fire festival celebrating Jeju's livestock farming heritage.",
                    "Dress warmly, as the festival often takes place outdoors in the colder months. Bring a camera to capture the stunning fireworks display.",
                    "fire festival, Jeju, South Korea, traditional, livestock, fireworks, bonfires",
                  ),
                  SwipableCard(
                      "https://api.cdn.visitjeju.net/photomng/imgpath/20180",
                      "Jeju Cherry Blossom Festival",
                      "Seogwipo and surrounding areas, Jeju Island, South Korea",
                      "Usually held in late March or early April",
                      "A beautiful festival celebrating the blooming of cherry blossoms.",
                      "Plan your visit during peak cherry blossom season for the best experience. Rent a bicycle to explore the scenic cherry blossom trails.",
                      "cherry blossom festival, Jeju, South Korea, spring, flowers, romance"),
                  SwipableCard(
                      "https://api.cdn.visitjeju.net/photomng/imgpath/202201/21/d7e94987-85dd-460f-8e4f-91fd5bb1fb6d.jpg",
                      "Tamnaguk Ipchungut",
                      "Gwandeok-ro, Jeju-si, Jeju Island, South Korea",
                      "Feb. 3~4",
                      "A exciting spring festival that prays for blessings t.",
                      "Participate in the rituals like Sarisalseong and Inchunhwiho, watch the parade, and enjoy traditi",
                      "Amnaguk Ipchungut, Jeju Island, Traditional festival, Cultural heritage, Rituals, Sarisalseong, Inchunhwiho, Segyeongje, Parade, Spring festival, Blessing"),
                  SwipableCard(
                      "https://goguides.azureedge.net/media/mgmg1ise/b1d9d5f4-ea88-4da0-b8b9-f5a59c0fbdf4.jpg?anchor=center&mode=crop&width=1600&height=1066&quality=50",
                      "Jeju Canola Flower Festival",
                      "Seogwipo-si, Jeju Island, South Korea",
                      "Usually held in spring (April)",
                      "Celebrate spring's arrival on Jeju Island amidst a vibrant sea of yellow canola flowers. This annual festival showcases the island's natural beauty and rich agricultural heritage.",
                      "Visit nearby sites like Noksanjang and Gammajang, once prominent horse breeding farms during the Joseon Dynasty. You might also catch the tail end of the cherry blossom season along Noksan-ro.",
                      "spring flowers, canola flowers, Gasi-ri, Noksan-ro, Seogwipo-si, Korea, flower festival."),
                  SwipableCard(
                      "https://api.cdn.visitjeju.net/photomng/imgpath/202201/21/077fc720-6df8-45db-b0ef-ae38b64f09b1.jpg",
                      "Tamna Cultural Festival",
                      "Traditional villages, Jeju Island, South Korea",
                      "Usually held in autumn (Early October)",
                      "A celebration of Jeju's rich folk culture and traditions.",
                      "Learn traditional crafts, watch folk performances, and experience local customs.",
                      "folk culture festival, Jeju, South Korea, traditional dance, music"),
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20.0),
                        const SearchBarWidget(),
                        const SizedBox(height: 20.0),
                        buildPlaceRow('Cultural Destinations', places, context),
                        buildPlaceList(context, places),
                        const SizedBox(
                          height: 5.0,
                        ),
                        buildPlaceRow('Local Cuisines', food, context),
                        buildPlaceList(context, food, isPlace: false),
                        const SizedBox(
                          height: 80,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: const ChatbotFloatButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget buildPlaceList(BuildContext context, List<Place> source,
      {isPlace = true}) {
    const Color selectedColor = Color(0xffEF7168);
    const Color textColor = Color(0xff6A778B);

    // Determine the selected tag and filter the source list
    String selectedTag = isPlace
        ? placeTag[selectedFilterPlace].toLowerCase()
        : foodTag[selectedFilterFood].toLowerCase();

    List<Place> filteredSource;

    if (isPlace && selectedFilterPlace == 0 ||
        !isPlace && selectedFilterFood == 0) {
      // If "Popular" is selected, display all places
      filteredSource = source;
    } else {
      // Otherwise, filter based on the selected tag (case-insensitive)
      filteredSource = source.where((place) {
        return place.tag.any((tag) => tag.toLowerCase() == selectedTag);
      }).toList();
    }

    return Column(
      children: [
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: isPlace ? placeTag.length : foodTag.length,
            itemBuilder: (context, index) {
              final isSelected = isPlace
                  ? selectedFilterPlace == index
                  : selectedFilterFood == index;
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: ChoiceChip(
                  showCheckmark: false,
                  label: Row(
                    children: [
                      Icon(
                        isPlace
                            ? _getIconForPlace(placeTag[index])
                            : _getIconForFood(foodTag[index]),
                        size: 20,
                        color: isSelected
                            ? Colors.white
                            : Colors.black.withOpacity(0.3),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isPlace ? placeTag[index] : foodTag[index],
                        style: GoogleFonts.montserrat(
                          color: isSelected ? Colors.white : textColor,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (isPlace) {
                        selectedFilterPlace = index;
                      } else {
                        selectedFilterFood = index;
                      }
                    });
                  },
                  selectedColor: selectedColor,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(
                      color:
                          isSelected ? selectedColor : const Color(0xffD6D6D6),
                      width: 1,
                    ),
                  ),
                  elevation: isSelected ? 3 : 0,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 240,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: filteredSource.length,
            itemBuilder: (BuildContext context, int index) {
              Place place = filteredSource[index];
              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: PlaceCard(place: place),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildPlaceRow(String place, List<Place> source, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          place,
          style: GoogleFonts.roboto(
            color: const Color(0xff171D19),
            fontSize: 21.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          child: Text(
            "View all",
            style: GoogleFonts.rubik(
              color: Colors.black.withOpacity(0.3),
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            Get.to(
              () => Trending(name: place, source: source),
              transition: Transition.rightToLeftWithFade,
            );
          },
        ),
      ],
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 0), child: SearchCard());
  }

  IconData _getIconForPlace(String tag) {
    switch (tag.toLowerCase()) {
      case "popular":
        return IconsaxPlusLinear.trend_up;
      case "lake":
        return BoxIcons.bx_water;
      case "beach":
        return Icons.beach_access;
      case "mountain":
        return Icons.terrain;
      case "city":
        return Icons.location_city;
      default:
        return Icons.filter_list;
    }
  }

  IconData _getIconForFood(String tag) {
    switch (tag.toLowerCase()) {
      case "popular":
        return IconsaxPlusLinear.trend_up;
      case "traditional":
        return BoxIcons.bx_building_house;
      case "marketplace":
        return BoxIcons.bx_store;
      case "street food":
        return BoxIcons.bx_food_menu;
      case "fruits":
        return BoxIcons.bx_lemon;
      case "snack":
        return BoxIcons.bx_cookie;
      case "fine dining":
        return BoxIcons.bx_dish;
      case "seafood":
        return BoxIcons.bx_food_menu;
      default:
        return Icons.filter_list;
    }
  }
}
