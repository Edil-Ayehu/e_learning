import 'package:e_learning/model/course.dart';
import 'package:flutter/material.dart';
import 'package:e_learning/utils/app_colors.dart';
import 'package:get/get.dart';

class CourseQuizPage extends StatefulWidget {
  final Course? course;
  const CourseQuizPage({super.key, this.course});

  @override
  State<CourseQuizPage> createState() => _CourseQuizPageState();
}

class _CourseQuizPageState extends State<CourseQuizPage> {
  int selectedAnswer = -1;
  int currentQuestion = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Assessment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressIndicator(),
            const SizedBox(height: 24),
            _buildQuestionCard(),
            const Spacer(),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question ${currentQuestion + 1} of 10',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: (currentQuestion + 1) / 10,
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
        ),
      ],
    );
  }

  Widget _buildQuestionCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What is the main purpose of this course?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            ...List.generate(4, (index) => _buildAnswerOption(index)),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOption(int index) {
    return RadioListTile(
      value: index,
      groupValue: selectedAnswer,
      onChanged: (value) {
        setState(() {
          selectedAnswer = value!;
        });
      },
      title: Text('Answer option ${index + 1}'),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: currentQuestion > 0 ? () {
            setState(() {
              currentQuestion--;
              selectedAnswer = -1;
            });
          } : null,
          child: const Text('Previous'),
        ),
        ElevatedButton(
          onPressed: selectedAnswer != -1 ? () {
            if (currentQuestion < 9) {
              setState(() {
                currentQuestion++;
                selectedAnswer = -1;
              });
            } else {
              Get.toNamed('/course-certificate');
            }
          } : null,
          child: Text(currentQuestion < 9 ? 'Next' : 'Finish'),
        ),
      ],
    );
  }
}
