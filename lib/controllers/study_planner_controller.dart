import 'package:get/get.dart';
import 'package:e_learning/model/study_plan.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class StudyPlannerController extends GetxController {
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  final Map<DateTime, List<StudyPlan>> events = {};
  List<StudyPlan> selectedEvents = [];
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    tz.initializeTimeZones();
    initializeNotifications();
    loadEvents();
  }

  Future<void> initializeNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await notificationsPlugin.initialize(initSettings);
  }

  Future<void> loadEvents() async {
    // TODO: Load events from local storage or backend
    // For now, let's add some sample events
    final today = DateTime.now();
    final samplePlan = StudyPlan(
      id: '1',
      title: 'Flutter Basics',
      startTime: today.add(const Duration(hours: 1)),
      endTime: today.add(const Duration(hours: 2)),
      courseId: '1',
      courseName: 'Flutter Development',
      type: PlanType.studySession,
      hasReminder: true,
    );
    
    await addStudyPlan(samplePlan);
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay = selected;
    focusedDay = focused;
    selectedEvents = getEventsForDay(selected);
    update();
  }

  List<StudyPlan> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  Future<void> addStudyPlan(StudyPlan plan) async {
    final day = DateTime(plan.startTime.year, plan.startTime.month, plan.startTime.day);
    if (events[day] == null) events[day] = [];
    events[day]!.add(plan);
    
    if (plan.hasReminder) {
      scheduleNotification(plan);
    }
    
    update();
  }

  Future<void> scheduleNotification(StudyPlan plan) async {
    const androidDetails = AndroidNotificationDetails(
      'study_reminders',
      'Study Reminders',
      importance: Importance.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    final scheduledDate = tz.TZDateTime.from(
      plan.startTime.subtract(const Duration(minutes: 15)),
      tz.local,
    );
    
    await notificationsPlugin.zonedSchedule(
      plan.hashCode,
      'Study Reminder',
      'Time to study: ${plan.title}',
      scheduledDate,
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

    void togglePlanCompletion(String planId) {
    for (var dayEvents in events.values) {
      for (var plan in dayEvents) {
        if (plan.id == planId) {
          // Since StudyPlan is immutable, create a new instance
          final updatedPlan = StudyPlan(
            id: plan.id,
            title: plan.title,
            startTime: plan.startTime,
            endTime: plan.endTime,
            courseId: plan.courseId,
            courseName: plan.courseName,
            type: plan.type,
            description: plan.description,
            hasReminder: plan.hasReminder,
            isCompleted: !plan.isCompleted,
          );
          
          // Replace the old plan with the updated one
          dayEvents[dayEvents.indexOf(plan)] = updatedPlan;
          break;
        }
      }
    }
    
    // Update the selected events list
    selectedEvents = getEventsForDay(selectedDay);
    update();
  }
}
