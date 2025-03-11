import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projects/utils/colorConstants.dart';
import 'package:projects/utils/commonWidgets/commonButton.dart';


class EventCalendar extends StatefulWidget {
  const EventCalendar({super.key});

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  List<int> years = List.generate(10, (index) => 2020 + index);
  List<String> days = ["Mo", "Tu", "We", "Thu", "Fr", "Sa", "Su"];

  @override
  void initState() {
    super.initState();
    selectedMonth = DateFormat('MMMM').format(today); // Set default month
    selectedYear = today.year; // Set default year
    selectedDay = today.day; // Set default selected day
  }

  DateTime today = DateTime.now(); // Get current date
  late String selectedMonth;
  late int selectedYear;
  late int selectedDay;

  var items = List.generate(25, (index) => ListItem("Lorem Ipsum","9-10 January"));

  @override
  Widget build(BuildContext context) {

    int monthIndex = months.indexOf(selectedMonth) + 1;
    int daysInMonth = DateTime(selectedYear, monthIndex + 1, 0).day; // Get valid days

    // Ensure selected day is within valid days of the month
    if (selectedDay > daysInMonth) {
      selectedDay = daysInMonth;
    }

    DateTime firstDayOfMonth = DateTime(selectedYear, monthIndex, 1);
    int firstDayOfWeek = firstDayOfMonth.weekday;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calendar', style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: blackColor
        ),),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFA54DB7),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height:24,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: DropdownButton<String>(
                        value: selectedMonth,
                        dropdownColor: Colors.white,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        items:
                        months.map((String month) {
                          return DropdownMenuItem<String>(
                            value: month,
                            child: Text(month),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedMonth = newValue!;
                            selectedDay = 1; // Reset to 1st of month
                          });
                        },
                      ),
                    ),
                    Container(
                      height:24,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: DropdownButton<int>(
                        value: selectedYear,
                        dropdownColor: Colors.white,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        items:
                        years.map((int year) {
                          return DropdownMenuItem<int>(
                            value: year,
                            child: Text(year.toString()),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedYear = newValue!;
                            selectedDay = 1; // Reset to 1st of month
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: days.map((day) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: daysInMonth,
                  itemBuilder: (context, index) {
                    int day = index + 1;
                    bool isToday = (day == today.day && selectedMonth == DateFormat('MMMM').format(today)
                        && selectedYear == today.year);
                    bool isSelected = (selectedDay == day);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDay = day;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                          isSelected
                              ? Colors
                              .white // Selected date color
                              : isToday
                              ? Colors
                              .white // Today's date color
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "$day",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:
                            isSelected || isToday
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("January Tasks"),
                Text("${items.length} Total"),
              ],
            ),
          ),
    Expanded(
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.only(top: 10),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        items[index].isSelected = !items[index].isSelected;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12, right: 20, left: 20),
                      padding: EdgeInsets.only(left: 13, right: 10, top: 8, bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(1, 2),
                            blurRadius: 6
                          )
                        ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(items[index].title),
                              Text(items[index].subTitle),
                            ],
                          ),
                          items[index].isSelected
                              ? CommonButton(
                            margin: EdgeInsets.only(top: 4),
                            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            radius: 5,
                            txtSize: 14,
                            txtWeight: FontWeight.w500,
                            btnTxt: "Done",
                          )
                              : Container(
                            margin: EdgeInsets.only(top: 4),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                            decoration: BoxDecoration(
                              color: blackColor,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text("View", style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500, color: whiteColor
                            ),),
                          )
                        ],
                      )
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class ListItem {
  String title;
  String subTitle;
  bool isSelected;

  ListItem(this.title, this.subTitle, {this.isSelected = false});
}