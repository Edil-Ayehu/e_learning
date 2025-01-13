class Course {
  final String title;
  final String instructor;
  final String imageUrl;
  final double progress;
  final String duration;

  Course({
    required this.title,
    required this.instructor,
    required this.imageUrl,
    required this.progress,
    required this.duration,
  });
}

class Category {
  final String name;
  final String icon;
  final int courseCount;

  Category({
    required this.name,
    required this.icon,
    required this.courseCount,
  });
}

final List<Course> featuredCourses = [
  Course(
    title: 'Flutter Development Masterclass',
    instructor: 'John Doe',
    imageUrl: 'https://picsum.photos/300/200',
    progress: 0.0,
    duration: '24h 30m',
  ),
  Course(
    title: 'UI/UX Design Fundamentals',
    instructor: 'Jane Smith',
    imageUrl: 'https://picsum.photos/300/201',
    progress: 0.0,
    duration: '12h 45m',
  ),
  // Add more courses as needed
];

final List<Category> categories = [
  Category(name: 'Development', icon: '💻', courseCount: 42),
  Category(name: 'Design', icon: '🎨', courseCount: 30),
  Category(name: 'Business', icon: '📊', courseCount: 25),
  Category(name: 'Marketing', icon: '📱', courseCount: 20),
  // Add more categories as needed
];

final List<Course> ongoingCourses = [
  Course(
    title: 'Advanced Flutter Architecture',
    instructor: 'Mike Johnson',
    imageUrl: 'https://picsum.photos/300/202',
    progress: 0.6,
    duration: '18h 20m',
  ),
  Course(
    title: 'Mobile App Design Workshop',
    instructor: 'Sarah Wilson',
    imageUrl: 'https://picsum.photos/300/203',
    progress: 0.3,
    duration: '15h 45m',
  ),
  // Add more ongoing courses as needed
];
