import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final List<Course> _courses = [
    Course(
      title: 'Introduction to Programming',
      description: 'Learn the basics of programming using Python.',
      image: 'assets/images/programming.png',
      instructor: 'Dr. Ahmed Ali',
      duration: '8 weeks',
      rating: 4.5,
      students: 200,
      category: 'Computer Science',
      status: 'Available',
    ),
    Course(
      title: 'Data Structures and Algorithms',
      description: 'An in-depth look at data structures and algorithms.',
      image: 'assets/images/data_structures.png',
      instructor: 'Dr. Sara Khaled',
      duration: '10 weeks',
      rating: 4.7,
      students: 180,
      category: 'Computer Science',
      status: 'Available',
    ),
    Course(
      title: 'Web Development Basics',
      description: 'Build websites using HTML, CSS, and JavaScript.',
      image: 'assets/images/web_development.png',
      instructor: 'Dr. Omar Farouk',
      duration: '6 weeks',
      rating: 4.8,
      students: 220,
      category: 'Web Development',
      status: 'Available',
    ),
    Course(
      title: 'Mobile App Development',
      description: 'Develop mobile applications for Android and iOS.',
      image: 'assets/images/mobile_app.png',
      instructor: 'Dr. Layla Hassan',
      duration: '12 weeks',
      rating: 4.6,
      students: 150,
      category: 'Mobile Development',
      status: 'Available',
    ),
    Course(
      title: 'Machine Learning Basics',
      description: 'Introduction to machine learning concepts.',
      image: 'assets/images/machine_learning.png',
      instructor: 'Dr. Tamer Ibrahim',
      duration: '14 weeks',
      rating: 4.9,
      students: 130,
      category: 'Data Science',
      status: 'Available',
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  late List<Course> _filteredCourses;
  bool _isLoading = true;
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _filteredCourses = _courses;
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  void _filterCourses(String query) {
    setState(() {
      _filteredCourses = _courses.where((course) =>
          course.title.toLowerCase().contains(query.toLowerCase()) ||
          course.description.toLowerCase().contains(query.toLowerCase()) ||
          course.instructor.toLowerCase().contains(query.toLowerCase())).toList();

      if (_selectedCategory != 'All') {
        _filteredCourses = _filteredCourses.where(
            (course) => course.category == _selectedCategory).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Course Catalog'),
        backgroundColor: Colors.blue[800],
        centerTitle: true,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(isLargeScreen ? 24.0 : 16.0),
          child: Column(
            children: [
              _buildSearchBar(),
              const SizedBox(height: 16),
              _buildCategoryFilter(),
              const SizedBox(height: 16),
              Expanded(
                child: _isLoading
                    ? _buildLoadingIndicator()
                    : _filteredCourses.isNotEmpty
                        ? _buildCourseGrid(isLargeScreen)
                        : _buildEmptyState(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search courses...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  _filterCourses('');
                },
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: _filterCourses,
    );
  }

  Widget _buildCategoryFilter() {
    final categories = ['All', 'Computer Science', 'Web Development', 'Mobile Development', 'Data Science'];
    
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(categories[index]),
              selected: _selectedCategory == categories[index],
              onSelected: (selected) => setState(() {
                _selectedCategory = selected ? categories[index] : 'All';
                _filterCourses(_searchController.text);
              }),
              selectedColor: Colors.blue[800],
              labelStyle: TextStyle(
                color: _selectedCategory == categories[index] ? Colors.white : Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCourseGrid(bool isLargeScreen) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLargeScreen ? 2 : 1,
        childAspectRatio: isLargeScreen ? 1.5 : 1.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredCourses.length,
      itemBuilder: (context, index) => CourseCard(
        course: _filteredCourses[index],
        onTap: () => _showCourseDetails(_filteredCourses[index]),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text('No courses found matching your criteria.'),
    );
  }

  void _showCourseDetails(Course course) {
    showDialog(
      context: context,
      builder: (context) => CourseDetailsDialog(course: course),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class Course {
  final String title;
  final String description;
  final String image;
  final String instructor;
  final String duration;
  final double rating;
  final int students;
  final String category;
  final String status;

  const Course({
    required this.title,
    required this.description,
    required this.image,
    required this.instructor,
    required this.duration,
    required this.rating,
    required this.students,
    required this.category,
    required this.status,
  });
}

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;

  const CourseCard({
    super.key,
    required this.course,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(course.status),
                    backgroundColor: Colors.green[100],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(course.rating.toString()),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      course.image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          course.instructor,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                course.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${course.students} students'),
                  Text(course.duration),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseDetailsDialog extends StatelessWidget {
  final Course course;

  const CourseDetailsDialog({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                course.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              _buildDetailRow('Instructor', course.instructor),
              _buildDetailRow('Duration', course.duration),
              _buildDetailRow('Students', '${course.students}'),
              _buildDetailRow('Category', course.category),
              _buildDetailRow('Status', course.status),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Enroll Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}