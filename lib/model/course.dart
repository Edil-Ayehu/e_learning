class Course {
  final String title;
  final String instructor;
  final String imageUrl;
  final double progress;
  final String duration;
  final String category;

  Course({
    required this.title,
    required this.instructor,
    required this.imageUrl,
    required this.progress,
    required this.duration,
    required this.category,
  });
}

class Category {
  final String name;
  final String icon;
  late final int courseCount;

  Category({
    required this.name,
    required this.icon,
  }) {
    courseCount = _calculateCourseCount();
  }

  int _calculateCourseCount() {
    return [...featuredCourses, ...ongoingCourses]
        .where((course) => course.category == name)
        .length;
  }
}

final List<Course> featuredCourses = [
  Course(
    title: 'Flutter Development Masterclass',
    instructor: 'John Doe',
    imageUrl: 'https://picsum.photos/300/200',
    progress: 0.0,
    duration: '24h 30m',
    category: 'Development',
  ),
  Course(
    title: 'UI/UX Design Fundamentals',
    instructor: 'Jane Smith',
    imageUrl: 'https://picsum.photos/300/201',
    progress: 0.0,
    duration: '12h 45m',
    category: 'Design',
  ),
  // Add more courses as needed
];

final List<Category> categories = [
  Category(name: 'Development', icon: '💻'),
  Category(name: 'Design', icon: '🎨'),
  Category(name: 'Business', icon: '📊'),
  Category(name: 'Marketing', icon: '📱'),
];

final List<Course> ongoingCourses = [
  Course(
    title: 'Advanced Flutter Architecture',
    instructor: 'Mike Johnson',
    imageUrl: 'https://picsum.photos/300/202',
    progress: 0.6,
    duration: '18h 20m',
    category: 'Development',
  ),
  Course(
    title: 'Mobile App Design Workshop',
    instructor: 'Sarah Wilson',
    imageUrl: 'https://picsum.photos/300/203',
    progress: 0.3,
    duration: '15h 45m',
    category: 'Design',
  ),
  Course(
    title: 'Digital Marketing Masterclass',
    instructor: 'Sarah Wilson',
    imageUrl: 'https://picsum.photos/300/203',
    progress: 0.3,
    duration: '15h 45m',
    category: 'Marketing',
  ),
  Course(
    title: 'Business Strategy Workshop',
    instructor: 'Sarah Wilson',
    imageUrl: 'https://picsum.photos/300/203',
    progress: 0.3,
    duration: '15h 45m',
    category: 'Business',
  ),
  // Add more ongoing courses as needed
];
