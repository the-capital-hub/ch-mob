import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityMeetingsController/community_meetings_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CommunityMeetingsCalendar extends StatefulWidget {
  String selectedDate;

  CommunityMeetingsCalendar({required this.selectedDate});

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<CommunityMeetingsCalendar> {
  CommunityMeetingsController communityMeetings = Get.find();
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  List<DateTime> dates = [];
  @override
  void initState() {
    super.initState();
    DateTime parsedDate = DateTime.parse(widget.selectedDate);
    dates.add(parsedDate);
    print(dates);

    // Set the _selectedDay to the first date in the dates list if it exists
    _selectedDay =
        dates.isNotEmpty ? dates.first : _normalizeDate(DateTime.now());
    _focusedDay = _normalizeDate(DateTime.now());
  }

  // Helper method to normalize DateTime to remove the time part
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            color: AppColors.blackCard,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: TableCalendar(
                  focusedDay: _focusedDay,
                  firstDay: DateTime(2000, 1, 1),
                  lastDay: DateTime(2050, 1, 1),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = _normalizeDate(selectedDay);
                      _focusedDay = focusedDay;
                    });
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  enabledDayPredicate: (day) {
                    return dates.any((d) =>
                        d.year == day.year &&
                        d.month == day.month &&
                        d.day == day.day);
                  },
                  calendarStyle: CalendarStyle(
                    disabledTextStyle: TextStyle(color: AppColors.white12),
                    todayDecoration: const BoxDecoration(
                      color: AppColors.blue,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    markersMaxCount: 1,
                    markerDecoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    markersAutoAligned: false,
                    markerSize: 5,
                    markersAlignment: Alignment.bottomCenter,
                    markerMargin: EdgeInsets.only(bottom: 10),
                  ),
                  headerStyle: HeaderStyle(
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: AppColors.white,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: AppColors.white,
                    ),
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white, // Title text color in header
                    ),
                    headerMargin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        color: AppColors.white,
                      ),
                      weekendStyle: TextStyle(
                        color: AppColors.white,
                      )),
                ),
              ),
            ),
          ),
          sizedTextfield, // Replace with your actual widget if required
        ],
      ),
    );
  }
}
