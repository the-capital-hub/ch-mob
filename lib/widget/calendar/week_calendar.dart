import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityWebinarsController/community_webinars_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// class CommunityEventsCalendar extends StatefulWidget {
//   final List<String>
//       availableDays; // List of days to display, e.g., ["Monday", "Wednesday", "Saturday"]
//   final int index;

//   CommunityEventsCalendar({required this.availableDays, required this.index});

//   @override
//   _EventCalendarState createState() => _EventCalendarState();
// }

// class _EventCalendarState extends State<CommunityEventsCalendar> {
//   CommunityWebinarsController communityEvents =
//       Get.put(CommunityWebinarsController());
//   late DateTime _selectedDay;
//   late DateTime _focusedDay;
//   int? _selectedIndex;
//   int? selectedDayIndex;

//   // List of weekdays to enable based on input days
//   List<int> availableWeekdays = [];

//   // Variable to store the selected day and its date

//   DateTime selectedDate = DateTime.now(); // To store the selected date

//   @override
//   void initState() {
//     super.initState();
//     _selectedDay = _normalizeDate(DateTime.now());
//     _focusedDay = _normalizeDate(DateTime.now());
//     _generateAvailableWeekdays(widget.availableDays);
//   }

//   // Helper method to normalize DateTime to remove the time part
//   DateTime _normalizeDate(DateTime date) {
//     return DateTime(date.year, date.month, date.day);
//   }

//   // Generate the list of available weekdays (e.g., Monday = 1, Tuesday = 2, etc.)
//   void _generateAvailableWeekdays(List<String> availableDays) {
//     availableWeekdays = availableDays.map((day) {
//       switch (day.toLowerCase()) {
//         case "monday":
//           return DateTime.monday;
//         case "tuesday":
//           return DateTime.tuesday;
//         case "wednesday":
//           return DateTime.wednesday;
//         case "thursday":
//           return DateTime.thursday;
//         case "friday":
//           return DateTime.friday;
//         case "saturday":
//           return DateTime.saturday;
//         case "sunday":
//           return DateTime.sunday;
//         default:
//           return -1; // Invalid day
//       }
//     }).toList();
//   }

//   // Method to check if a day is available based on the weekdays
//   bool _isDayAvailable(DateTime day) {
//     return availableWeekdays.contains(day.weekday) &&
//         day.isAfter(
//             _normalizeDate(DateTime.now())); // Ensure the day is after today
//   }

//   // Method to get the name of the selected day
//   String _getDayName(DateTime day) {
//     switch (day.weekday) {
//       case DateTime.monday:
//         return 'Monday';
//       case DateTime.tuesday:
//         return 'Tuesday';
//       case DateTime.wednesday:
//         return 'Wednesday';
//       case DateTime.thursday:
//         return 'Thursday';
//       case DateTime.friday:
//         return 'Friday';
//       case DateTime.saturday:
//         return 'Saturday';
//       case DateTime.sunday:
//         return 'Sunday';
//       default:
//         return ''; // Return empty string if something goes wrong
//     }
//   }
// bool noSlot = true;
//   checkSlots(){
//     for(int i=0;i<communityEvents
//                         .communityWebinarsList[widget.index]
//                         .availability![communityEvents.selectedDayIndex]
//                         .slots!
//                         .length; i++)
//                         {
//                           if (communityEvents
//                         .communityWebinarsList[widget.index]
//                         .availability![communityEvents.selectedDayIndex]
//                         .slots![i].isAvailable!){
//                           setState(() {
//                             noSlot = !noSlot;
//                           });
//                         }

//                         }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Card(
//               color: AppColors.blackCard,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SingleChildScrollView(
//                   child: TableCalendar(
//                     focusedDay: _focusedDay,
//                     firstDay: DateTime(2000, 1, 1),
//                     lastDay: DateTime(2050, 1, 1),
//                     onDaySelected: (selectedDay, focusedDay) {
//                       setState(() {
//                         // communityEvents.isDaySelected =
//                         //     !communityEvents.isDaySelected;
//                         _selectedDay = _normalizeDate(selectedDay);
//                         _focusedDay = focusedDay;
//                         checkSlots();

//                         // Store the selected date and corresponding day name
//                         selectedDate = selectedDay; // Store the selected date
//                         communityEvents.formattedDate =
//                             DateFormat('MMMM d').format(selectedDate);
//                         communityEvents.selectedDayName = _getDayName(
//                             selectedDay); // Store the name of the day
//                         for (int i = 0;
//                             i <
//                                 communityEvents.communityWebinarsList[0]
//                                     .availability!.length;
//                             i++) {
//                           if (communityEvents
//                                   .communityWebinarsList[widget.index]
//                                   .availability![i]
//                                   .day! ==
//                               communityEvents.selectedDayName) {
//                             communityEvents.selectedDayIndex = i;
//                           }
//                         }
//                         print(communityEvents.formattedDate);
//                         print(communityEvents.selectedDayName);
//                         print(communityEvents.selectedDayIndex);
//                       });

//                       // You can print or use the values as required
//                       // print("Selected Date: $selectedDate");
//                       // print("Selected Day: $selectedDayName");
//                       // print("Selected Day2: ${communityEvents.formattedDate}");
//                     },
//                     selectedDayPredicate: (day) {
//                       return isSameDay(_selectedDay, day);
//                     },
//                     enabledDayPredicate: (day) {
//                       // Only enable the days that are in the 'availableWeekdays' list and after today
//                       return _isDayAvailable(day);
//                     },
//                     calendarStyle: CalendarStyle(
//                       defaultTextStyle: TextStyle(
//                           color: AppColors.white // Text color for enabled dates
//                           ),
//                       disabledTextStyle: TextStyle(
//                           color:
//                               AppColors.white12 // Text color for disabled dates
//                           ),
//                       // You can also customize enabled date's background
//                       todayTextStyle: TextStyle(
//                         color: AppColors.white54, // Text color for today
//                       ),

//                       todayDecoration: BoxDecoration(
//                         color: AppColors.blue,
//                         shape: BoxShape.circle,
//                       ),
//                       selectedDecoration: BoxDecoration(
//                         color: AppColors.primary,
//                         shape: BoxShape.circle,
//                       ),
//                       markersMaxCount: 1,
//                       markerDecoration: BoxDecoration(
//                         color: AppColors.primary,
//                         shape: BoxShape.circle,
//                       ),
//                       markersAutoAligned: false,
//                       markerSize: 5,
//                       markersAlignment: Alignment.bottomCenter,
//                       markerMargin: EdgeInsets.only(bottom: 10),
//                     ),
//                     headerStyle: HeaderStyle(
//                       leftChevronIcon: Icon(
//                         Icons.chevron_left,
//                         color: AppColors.white,
//                       ),
//                       rightChevronIcon: Icon(
//                         Icons.chevron_right,
//                         color: AppColors.white,
//                       ),
//                       formatButtonVisible: false,
//                       titleCentered: true,
//                       titleTextStyle: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.white, // Title text color in header
//                       ),
//                       headerMargin: EdgeInsets.only(bottom: 10),
//                       decoration: BoxDecoration(
//                         color: AppColors.primary.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     daysOfWeekStyle: DaysOfWeekStyle(
//                         weekdayStyle: TextStyle(
//                           color: AppColors.white,
//                         ),
//                         weekendStyle: TextStyle(
//                           color: AppColors.white,
//                         )),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // Example of using selected values
//           // Text('Selected Date: ${selectedDate.toLocal()}'),
//           // Text('Selected Day: $selectedDayName'),
//           // sizedTextfield,
//           // if (communityEvents.isDaySelected)

//                 // :

// noSlot?

//               SizedBox(
//                     height: 100,

//                     child: TextWidget(text: "No Slots available", textSize: 16)):
//                 Wrap(
//                     spacing: 4.0,
//                     runSpacing: 4.0,
//                     children: List.generate(
//                       communityEvents
//                           .communityWebinarsList[widget.index]
//                           .availability![communityEvents.selectedDayIndex]
//                           .slots!
//                           .length,
//                       (index) {
//                         bool isSlotSelected = _selectedIndex == index;
//                         return communityEvents
//                                 .communityWebinarsList[widget.index]
//                                 .availability![
//                                     communityEvents.selectedDayIndex]
//                                 .slots![index]
//                                 .isAvailable!
//                             ? InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     isSlotSelected = !isSlotSelected;
//                                     if (_selectedIndex == index) {
//                                       _selectedIndex = null;
//                                     } else {
//                                       _selectedIndex = index;
//                                     }

//                                     communityEvents.slot = isSlotSelected
//                                         ? "${communityEvents.communityWebinarsList[widget.index].availability![communityEvents.selectedDayIndex].slots![index].startTime} - ${communityEvents.communityWebinarsList[widget.index].availability![communityEvents.selectedDayIndex].slots![index].endTime}"
//                                         : "";
//                                     communityEvents.startTime =
//                                         communityEvents
//                                             .communityWebinarsList[widget.index]
//                                             .availability![communityEvents
//                                                 .selectedDayIndex]
//                                             .slots![index]
//                                             .startTime!;
//                                     communityEvents.endTime =
//                                         communityEvents
//                                             .communityWebinarsList[widget.index]
//                                             .availability![communityEvents
//                                                 .selectedDayIndex]
//                                             .slots![index]
//                                             .endTime!;
//                                   });
//                                 },
//                                 child: Card(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                   color: isSlotSelected
//                                       ? AppColors.primary
//                                       : AppColors.white12,
//                                   surfaceTintColor: AppColors.white12,
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 12, vertical: 4),
//                                     child: TextWidget(
//                                       text:
//                                           "${communityEvents.communityWebinarsList[widget.index].availability![communityEvents.selectedDayIndex].slots![index].startTime} - ${communityEvents.communityWebinarsList[widget.index].availability![communityEvents.selectedDayIndex].slots![index].endTime}",
//                                       textSize: 14,
//                                       color: AppColors.white,
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             : const SizedBox.shrink();
//                       },
//                     ),
//                   ),
//         ],
//       ),
//     );
//   }
// }
class CommunityEventsCalendar extends StatefulWidget {
  final List<String> availableDays;
  final int index;

  const CommunityEventsCalendar(
      {super.key, required this.availableDays, required this.index});

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<CommunityEventsCalendar> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  int? _selectedIndex;
  int? selectedDayIndex;

  List<int> availableWeekdays = [];
  DateTime selectedDate = DateTime.now();
  CommunityEventsController communityEvents = Get.find();
  // @override
  // void initState() {
  //   super.initState();
  //   _selectedDay = _normalizeDate(DateTime.now());
  //   _focusedDay = _normalizeDate(DateTime.now());
  //   _generateAvailableWeekdays(widget.availableDays);
  //   communityEvents.isDaySelected = true;
  // }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

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
          return -1;
      }
    }).toList();
  }

  bool _isDayAvailable(DateTime day) {
    return availableWeekdays.contains(day.weekday) &&
        day.isAfter(_normalizeDate(DateTime.now()));
  }

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
        return '';
    }
  }

  // Helper method to check if there are any available slots
  bool _hasAvailableSlots() {
    return true;
  }

  // @override
  // void initState() {
  //   super.initState();

  //   // Set the selected day to today if it's available, otherwise set it to the next available day
  //   _selectedDay = _getNextAvailableDay(widget.availableDays);
  //   communityEvents.formattedDate = DateFormat('MMMM d').format(_selectedDay);
  //   _focusedDay = _selectedDay;
  //   communityEvents.selectedDayIndex;

  //   // Generate available weekdays
  //   _generateAvailableWeekdays(widget.availableDays);

  //   // communityEvents.isDaySelected = false;
  // }

  DateTime _getNextAvailableDay(List<String> availableDays) {
    int currentWeekday = DateTime.now().weekday; // Get current weekday

    // Loop through available days and find the next available day from today onwards
    for (String day in availableDays) {
      int dayIndex = _getWeekdayIndex(day); // Get index of available day
      if (dayIndex >= currentWeekday) {
        // If day is today or later
        return _getDateForNextWeekday(dayIndex); // Return the day
      }
    }

    // If no available day is later in the week, return the first available day in the next week
    int firstAvailableDayIndex = _getWeekdayIndex(availableDays.first);
    return _getDateForNextWeekday(firstAvailableDayIndex);
  }

  @override
  void initState() {
    super.initState();

    // Get the next available DateTime based on availableDays
    _selectedDay = _getNextAvailableDay(widget.availableDays);
    _focusedDay = _selectedDay;

    // Format and assign to the controller
    communityWebinars.formattedDate = DateFormat('MMMM d').format(_selectedDay);

    // Generate available weekdays (for checking valid days)
    _generateAvailableWeekdays(widget.availableDays);

    // Find the day name from the selected DateTime (e.g., 'Monday')
    String selectedDayName = _getDayName(_selectedDay).toLowerCase();

    // Find index of this day name in the original availableDays list
    selectedDayIndex = widget.availableDays.indexWhere(
      (day) => day.toLowerCase() == selectedDayName,
    );

    // Also update in your controller if needed
    communityWebinars.selectedDayIndex = selectedDayIndex!;
  }

  int _getWeekdayIndex(String day) {
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
  }

  DateTime _getDateForNextWeekday(int weekday) {
    DateTime today = DateTime.now();
    int daysToAdd =
        (weekday - today.weekday + 7) % 7; // Calculate how many days to add

    if (daysToAdd == 0) {
      daysToAdd = 0; // If it's today, no need to add any days
    } else if (daysToAdd < 0) {
      daysToAdd = daysToAdd + 7; // If the day is in the next week
    }

    return today
        .add(Duration(days: daysToAdd)); // Return the next available day
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
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

                        selectedDate = selectedDay;
                        communityWebinars.formattedDate =
                            DateFormat('MMMM d').format(selectedDate);
                        communityWebinars.selectedDayName =
                            _getDayName(selectedDay);
                      });
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    enabledDayPredicate: (day) {
                      return _isDayAvailable(day);
                    },
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: TextStyle(color: AppColors.white),
                      disabledTextStyle: TextStyle(color: AppColors.white12),
                      todayTextStyle: TextStyle(color: AppColors.white54),
                      todayDecoration: const BoxDecoration(
                        color: AppColors.blue,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: GetStoreData.getStore.read('isInvestor')
                            ? AppColors.primaryInvestor
                            : AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      weekendTextStyle: TextStyle(color: AppColors.white),
                    ),
                    headerStyle: HeaderStyle(
                      leftChevronIcon:
                          Icon(Icons.chevron_left, color: AppColors.white),
                      rightChevronIcon:
                          Icon(Icons.chevron_right, color: AppColors.white),
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
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
          ),
        ],
      ),
    );
  }
}
