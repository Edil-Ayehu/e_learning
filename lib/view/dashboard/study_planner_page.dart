import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:e_learning/model/study_plan.dart';
import 'package:e_learning/utils/app_colors.dart';
import 'package:e_learning/controllers/study_planner_controller.dart';

class StudyPlannerPage extends StatelessWidget {
  final studyPlannerController = Get.put(StudyPlannerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCalendar(),
          const Divider(),
          _buildEventsList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPlanDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCalendar() {
    return GetBuilder<StudyPlannerController>(
      builder: (controller) => TableCalendar(
        firstDay: DateTime.now().subtract(const Duration(days: 365)),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        focusedDay: controller.focusedDay,
        selectedDayPredicate: (day) => isSameDay(controller.selectedDay, day),
        eventLoader: controller.getEventsForDay,
        onDaySelected: controller.onDaySelected,
        calendarStyle: CalendarStyle(
          markerDecoration: BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildEventsList() {
    return Expanded(
      child: GetBuilder<StudyPlannerController>(
        builder: (controller) => ListView.builder(
          itemCount: controller.selectedEvents.length,
          itemBuilder: (context, index) {
            final event = controller.selectedEvents[index];
            return _buildEventTile(event);
          },
        ),
      ),
    );
  }

  Widget _buildEventTile(StudyPlan plan) {
    return ListTile(
      leading: _getIconForPlanType(plan.type),
      title: Text(plan.title),
      subtitle: Text(
          '${plan.startTime.hour}:${plan.startTime.minute} - ${plan.courseName}'),
      trailing: Checkbox(
        value: plan.isCompleted,
        onChanged: (value) =>
            studyPlannerController.togglePlanCompletion(plan.id),
      ),
    );
  }

  // ... existing code ...

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Events'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text('Study Sessions'),
              value: true, // Connect to controller
              onChanged: (value) {
                // Implement filter logic
                Navigator.pop(context);
              },
            ),
            CheckboxListTile(
              title: const Text('Deadlines'),
              value: true, // Connect to controller
              onChanged: (value) {
                // Implement filter logic
                Navigator.pop(context);
              },
            ),
            CheckboxListTile(
              title: const Text('Milestones'),
              value: true, // Connect to controller
              onChanged: (value) {
                // Implement filter logic
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Apply filters
              Navigator.pop(context);
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _showAddPlanDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String title = '';
    DateTime startTime = DateTime.now();
    DateTime endTime = DateTime.now().add(const Duration(hours: 1));
    String courseName = '';
    PlanType planType = PlanType.studySession;
    bool hasReminder = true;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Study Plan'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter a title' : null,
                  onSaved: (value) => title = value ?? '',
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<PlanType>(
                  decoration: const InputDecoration(labelText: 'Type'),
                  value: planType,
                  items: PlanType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.toString().split('.').last),
                    );
                  }).toList(),
                  onChanged: (value) => planType = value!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Course Name'),
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Please enter a course name'
                      : null,
                  onSaved: (value) => courseName = value ?? '',
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Start Time'),
                  subtitle: Text(startTime.toString()),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(startTime),
                    );
                    if (time != null) {
                      startTime = DateTime(
                        startTime.year,
                        startTime.month,
                        startTime.day,
                        time.hour,
                        time.minute,
                      );
                    }
                  },
                ),
                ListTile(
                  title: const Text('End Time'),
                  subtitle: Text(endTime.toString()),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(endTime),
                    );
                    if (time != null) {
                      endTime = DateTime(
                        endTime.year,
                        endTime.month,
                        endTime.day,
                        time.hour,
                        time.minute,
                      );
                    }
                  },
                ),
                SwitchListTile(
                  title: const Text('Set Reminder'),
                  value: hasReminder,
                  onChanged: (value) => hasReminder = value,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                formKey.currentState?.save();
                final plan = StudyPlan(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: title,
                  startTime: startTime,
                  endTime: endTime,
                  courseId: '1', // Replace with actual course ID
                  courseName: courseName,
                  type: planType,
                  hasReminder: hasReminder,
                );
                studyPlannerController.addStudyPlan(plan);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget _getIconForPlanType(PlanType type) {
    switch (type) {
      case PlanType.studySession:
        return const Icon(Icons.book, color: AppColors.primaryColor);
      case PlanType.deadline:
        return const Icon(Icons.timer, color: AppColors.errorColor);
      case PlanType.milestone:
        return const Icon(Icons.flag, color: AppColors.successColor);
      case PlanType.quiz:
        return const Icon(Icons.quiz, color: AppColors.warningColor);
      default:
        return const Icon(Icons.event_note);
    }
  }
}
