import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:stour/screens/timeline_screen.dart';
import 'package:intl/intl.dart';
import 'package:stour/util/const.dart';
import 'package:stour/screens/chatbot.dart';
import 'package:stour/model/upstage.dart';
import 'package:stour/util/places.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});
  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  DateTime _departureDate = DateTime.now();
  DateTime _returnDate = DateTime.now();
  double _maxBudget = 0;
  bool _isTravelingAlone = true;
  TimeOfDay _startTime = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 0, minute: 0);
  // ignore: unused_field
  int _travellerNum = 1;
  String _currentLocation = 'Ho Chi Minh city';
  List<String> cities = [
    "Ho Chi Minh city",
    "Ha Noi",
    "Da Nang",
    "Hoi An",
    "Can Tho"
  ];
  List<String> content = [];

  void _generateSchedule() async {
    {
      final response = await getUpstageAIResponse(
          "Use the places in this list: ${content.join(',')}",
          getSchedulePrompt(_departureDate, _returnDate, 2, _maxBudget));
      List<String> placeNames = response.split('"places"');
      placeNames = placeNames.map((e) {
        return e.split('"')[1];
      }).toList();
      placeNames.removeAt(0);
      List<List<Place>> placeList = [];

      for (var i = 0; i < placeNames.length; i++) {
        List<Place> tmp = [];
        for (var j = 0; j < 3 && i < placeNames.length; j++, i++) {
          for (var place in places) {
            if (place.name == placeNames[i]) {
              tmp.add(place);
            }
          }
        }
        placeList.add(tmp);
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleScreen(
            placeList: placeList,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    _departureDate = DateTime.now();
    _returnDate = DateTime.now();
    _maxBudget = 0;
    _startTime = const TimeOfDay(hour: 0, minute: 0);
    _endTime = const TimeOfDay(hour: 0, minute: 0);
    content.addAll(places.map((place) => place.name));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.palette3,
        title: Text('Initerary Planning',
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              color: Constants.paletteDark,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    Icons.location_pin, // or Icons.map
                    size: 25,
                    color: Constants.paletteDark,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    'Location:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Constants.paletteDark,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () async {
                      final String? picked = await showDialog<String>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Select Location'),
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  for (int i = 0; i < cities.length; i++)
                                    ListTile(
                                      title: Text(
                                        cities[i],
                                        style: TextStyle(
                                          color: Constants.paletteDark,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context, cities[i]);
                                      },
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                      if (picked != null) {
                        setState(() {
                          _currentLocation = picked;
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          _currentLocation,
                          style: const TextStyle(
                              color: Color(0xFF508C9B),
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 4.0),
                        const Icon(
                          Icons.edit, // or Icons.map
                          size: 16,
                          color: Color(0xFF508C9B),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Departure Date',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Constants.paletteDark,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: _departureDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() {
                              _departureDate = picked;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.palette3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: Icon(
                          CupertinoIcons.calendar,
                          color: Constants.paletteDark,
                        ),
                        label: Text(
                          DateFormat('dd/MM/yyyy').format(_departureDate),
                          style: TextStyle(color: Constants.paletteDark),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(width: 30),
                  const Spacer(),
                  Column(
                    children: [
                      Text('Return Date',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Constants.paletteDark)),
                      const SizedBox(height: 8.0),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: _returnDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() {
                              _returnDate = picked;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.palette3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: Icon(
                          CupertinoIcons.calendar,
                          color: Constants.paletteDark,
                        ),
                        label: Text(
                          DateFormat('dd/MM/yyyy').format(_returnDate),
                          style: TextStyle(color: Constants.paletteDark),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                'Budget (VND)',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Constants.paletteDark),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                textAlignVertical: TextAlignVertical.bottom,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) {
                  setState(() {
                    _maxBudget = double.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter your budget',
                  prefixIcon: Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Constants.paletteDark,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Traveling Alone?',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Constants.paletteDark),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Radio(
                    value: true,
                    activeColor: Constants.paletteDark,
                    groupValue: _isTravelingAlone,
                    onChanged: (value) {
                      setState(() {
                        _isTravelingAlone = value ?? false;
                      });
                    },
                  ),
                  Text('Yes',
                      style: TextStyle(
                          color: Constants.paletteDark,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(width: 16.0),
                  Radio(
                    value: false,
                    activeColor: Constants.palette2,
                    groupValue: _isTravelingAlone,
                    onChanged: (value) {
                      setState(() {
                        _isTravelingAlone = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    'No',
                    style: TextStyle(
                      color: Color.fromARGB(255, 35, 52, 10),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              if (!_isTravelingAlone)
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.bottom,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      setState(() {
                        _travellerNum = int.tryParse(value) ?? 1;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter number of travelers',
                      prefixIcon: Icon(
                        Icons.group,
                        color: Constants.paletteDark,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Column(
                    children: [
                      Text('Start of Day',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Constants.paletteDark)),
                      const SizedBox(height: 2.0),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: _startTime,
                          );
                          if (picked != null) {
                            setState(() {
                              _startTime = picked;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.palette3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: const Icon(
                          CupertinoIcons.clock,
                          color: Color.fromARGB(255, 64, 64, 63),
                        ),
                        label: Text(
                          _startTime.format(context),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        'End of Day',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Constants.paletteDark),
                      ),
                      const SizedBox(height: 2.0),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: _endTime,
                          );
                          if (picked != null) {
                            setState(() {
                              _endTime = picked;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.palette3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: const Icon(
                          CupertinoIcons.clock,
                          color: Color.fromARGB(255, 64, 64, 63),
                        ),
                        label: Text(
                          _endTime.format(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              Center(
                child: ElevatedButton(
                  onPressed: _generateSchedule,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4E7C5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text(
                    'Start Planning',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 35, 52, 10)),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                '*Note: The budget is an estimated cost for the accommodations, transportation fees are not included. Please take this factor into consideration.',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
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
