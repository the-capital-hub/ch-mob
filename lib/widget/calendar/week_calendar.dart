import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityMeetingsController/community_meetings_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityWebinarsController/community_webinars_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/datePicker/datePicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CommunityEventsCalendar extends StatefulWidget {
  final List<String> availableDays; // List of days to display, e.g., ["Monday", "Wednesday", "Saturday"]

  CommunityEventsCalendar({required this.availableDays});

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<CommunityEventsCalendar> {
  CommunityWebinarsController communityWebinars =
      Get.put(CommunityWebinarsController());
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  // List of weekdays to enable based on input days
  List<int> availableWeekdays = [];

  // Variable to store the selected day and its date
  String selectedDayName = ''; // To store the name of the selected day
  DateTime selectedDate = DateTime.now(); // To store the selected date

  @override
  void initState() {
    super.initState();
    _selectedDay = _normalizeDate(DateTime.now());
    _focusedDay = _normalizeDate(DateTime.now());
    _generateAvailableWeekdays(widget.availableDays);
  }

  // Helper method to normalize DateTime to remove the time part
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // Generate the list of available weekdays (e.g., Monday = 1, Tuesday = 2, etc.)
  void _generateAvailableWeekdays(List<String> availableDays) {
    availableWeekdays = availableDays.map((day) {
      switch (day.toLowerCase()) {
        case "monday":
          return DateTime.monday;
        case "tuesday":
          return DateTime.tuesday;
        case "wednesday":
          return DateTime.wednesday;
        case "thursday":
          return DateTime.thursday;
        case "friday":
          return DateTime.friday;
        case "saturday":
          return DateTime.saturday;
        case "sunday":
          return DateTime.sunday;
        default:
          return -1; // Invalid day
      }
    }).toList();
  }

  // Method to check if a day is available based on the weekdays
  bool _isDayAvailable(DateTime day) {
    return availableWeekdays.contains(day.weekday) &&
        day.isAfter(_normalizeDate(DateTime.now())); // Ensure the day is after today
  }

  // Method to get the name of the selected day
  String _getDayName(DateTime day) {
    switch (day.weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return ''; // Return empty string if something goes wrong
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: AppColors.blackCard,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime(2000, 1, 1),
                lastDay: DateTime(2050, 1, 1),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = _normalizeDate(selectedDay);
                    _focusedDay = focusedDay;

                    // Store the selected date and corresponding day name
                    selectedDate = selectedDay;  // Store the selected date
                    communityWebinars.formattedDate =
                                          DateFormat('MMMM d')
                                              .format(selectedDate);
                    selectedDayName = _getDayName(selectedDay); // Store the name of the day
                  });

                  // You can print or use the values as required
                  // print("Selected Date: $selectedDate");
                  // print("Selected Day: $selectedDayName");
                  // print("Selected Day2: ${communityWebinars.formattedDate}");
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                enabledDayPredicate: (day) {
                  // Only enable the days that are in the 'availableWeekdays' list and after today
                  return _isDayAvailable(day);
                },
                
                calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(
                    color: AppColors.white // Text color for enabled dates
                  ),
                  disabledTextStyle: TextStyle(
                    color: AppColors.white12 // Text color for disabled dates
                  ),
                  // You can also customize enabled date's background
                  todayTextStyle: TextStyle(
                    color: AppColors.white54, // Text color for today
                  ),
                  
                  todayDecoration: BoxDecoration(
                    color: AppColors.blue,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  markersMaxCount: 1,
                  markerDecoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  markersAutoAligned: false,
                  markerSize: 5,
                  markersAlignment: Alignment.bottomCenter,
                  markerMargin: EdgeInsets.only(bottom: 10),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: AppColors.white),
                  headerMargin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
        ),
        // Example of using selected values
        // Text('Selected Date: ${selectedDate.toLocal()}'),
        // Text('Selected Day: $selectedDayName'),
      ],
    );
  }
}

