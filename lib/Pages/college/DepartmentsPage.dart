import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hue/core/utils/app_colors.dart';

class Department {
  final String name;
  final String imagePath;
  final List<Department>? subDepartments;

  const Department({
    required this.name,
    required this.imagePath,
    this.subDepartments,
  });
}

Map<String, List<Department>> departmentData = {
  'AICS': [
    Department(
      name: 'Academic Programs',
      imagePath: 'assets/images/Logoblue.png',
      subDepartments: [
        Department(name: 'Machine Learning', imagePath: 'Logoblue.png'),
        Department(name: 'Cybersecurity', imagePath: ''),
        Department(name: 'Data Science', imagePath: '')
      ],
    ),
    Department(
      name: 'Research & Development',
      imagePath: '',
      subDepartments: [
        Department(name: 'AI Research', imagePath: ''),
        Department(name: 'Blockchain Security', imagePath: '')
      ],
    ),
  ],
  'Engineering': [
    Department(name: 'Mechanical Engineering', imagePath: ''),
    Department(name: 'Electrical Engineering', imagePath: ''),
  ],
};

class DepartmentsPage extends StatelessWidget {
  final String collegeName;

  const DepartmentsPage({super.key, required this.collegeName});

  @override
  Widget build(BuildContext context) {
    final departments = departmentData[collegeName] ?? [];

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context, departments),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: DepartmentColors.appBarColor,
      elevation: 0,
      title: Row(
        children: [
          Image.asset(
            'assets/images/Logoblue.png',
            height: 40,
            color: Colors.white,
          ),
          const SizedBox(width: 15),
          Text(
            collegeName,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget _buildBody(BuildContext context, List<Department> departments) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            DepartmentColors.bodyGradientStart,
            DepartmentColors.bodyGradientMiddle,
            DepartmentColors.bodyGradientEnd,
          ],
          stops: const [0.1, 0.3, 0.7],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: departments.isEmpty
            ? _buildEmptyState()
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: departments.length,
                itemBuilder: (context, index) =>
                    DepartmentCard(department: departments[index]),
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 60,
            color: DepartmentColors.emptyStateIconColor,
          ),
          const SizedBox(height: 20),
          Text(
            'لا توجد أقسام متاحة حالياً',
            style: TextStyle(
              fontSize: 18,
              color: DepartmentColors.emptyStateTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class DepartmentCard extends StatelessWidget {
  final Department department;

  const DepartmentCard({super.key, required this.department});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _handleTap(context),
        splashColor: DepartmentColors.cardSplashColor,
        highlightColor: DepartmentColors.cardHighlightColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                DepartmentColors.cardGradientStart,
                DepartmentColors.cardGradientMiddle,
                DepartmentColors.cardGradientEnd,
              ],
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImage(),
              const SizedBox(height: 12),
              _buildTitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Hero(
      tag: department.imagePath,
      child: CircleAvatar(
        radius: 40,
        backgroundColor: DepartmentColors.cardImageBackground,
        child: ClipOval(
          child: Image.asset(
            department.imagePath,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Icon(
              Icons.school,
              color: DepartmentColors.cardImageErrorColor,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      department.name,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: DepartmentColors.cardTitleColor,
        height: 1.3,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  void _handleTap(BuildContext context) {
    HapticFeedback.lightImpact();
    if (department.subDepartments != null && department.subDepartments!.isNotEmpty) {
      // ✅ فتح صفحة الأقسام الفرعية عند النقر
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DepartmentsPage(collegeName: department.name),
        ),
      );
    } else {
      // ✅ الانتقال إلى صفحة تفاصيل القسم
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DepartmentDetailsPage(department: department),
        ),
      );
    }
  }
}

class DepartmentDetailsPage extends StatelessWidget {
  final Department department;

  const DepartmentDetailsPage({super.key, required this.department});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(department.name),
      ),
      body: Center(
        child: Hero(
          tag: department.imagePath,
          child: Image.asset(department.imagePath),
        ),
      ),
    );
  }
}
