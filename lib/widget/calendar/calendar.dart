import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityWebinarsController/community_webinars_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendar extends StatefulWidget {
  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  CommunityWebinarsController communityWebinars = Get.find();
  // late List<DateTime> _events;
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  List<DateTime> dates = [
    DateTime(2025, 3, 10),
    DateTime(2025, 3, 12),
    DateTime(2025, 3, 15),
    DateTime(2025, 3, 18),
    DateTime(2025, 3, 20),
    DateTime(2025, 3, 25),
  ];
  
  @override
  void initState() {
    super.initState();
    _selectedDay = _normalizeDate(DateTime.now());
    _focusedDay = _normalizeDate(DateTime.now());
  }

  // Helper method to normalize DateTime to remove the time part
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: AppColors.whiteCard,
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
                  });
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                enabledDayPredicate: (day) {
                  // Only enable days that are in the 'dates' list
                  return dates.any((d) =>
                      d.year == day.year &&
                      d.month == day.month &&
                      d.day == day.day);
                },
                calendarStyle: CalendarStyle(
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
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  headerMargin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
        ),
        sizedTextfield,  // Replace with your actual widget if required
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 12),
            Expanded(
              child: AppButton.outlineButton(
                onButtonPressed: () {
                  Get.back(result: false);
                },
                height: 40,
                title: "Cancel",
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: AppButton.primaryButton(
                onButtonPressed: () {
                  Get.back(result: true);
                  communityWebinars.selectDate = _selectedDay;
                },
                height: 40,
                title: "Done",
              ),
            ),
            SizedBox(width: 12),
          ],
        ),
      ],
    );
  }
}
