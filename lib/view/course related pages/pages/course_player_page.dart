import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:e_learning/utils/app_colors.dart';

class CoursePlayerPage extends StatefulWidget {
  const CoursePlayerPage({super.key});

  @override
  State<CoursePlayerPage> createState() => _CoursePlayerPageState();
}

class _CoursePlayerPageState extends State<CoursePlayerPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'video_url_here',
    )..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayer(_controller),
            ),
            _buildVideoControls(),
            Expanded(
              child: _buildLessonsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              _controller.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
            ),
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
          ),
          Expanded(
            child: VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonsList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(
            Icons.play_circle_outline,
            color: AppColors.primaryColor,
          ),
          title: Text('Lesson ${index + 1}'),
          subtitle: Text('15:00'),
          trailing: Icon(
            Icons.check_circle,
            color: AppColors.primaryColor,
          ),
          onTap: () {
            // Handle lesson selection
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
