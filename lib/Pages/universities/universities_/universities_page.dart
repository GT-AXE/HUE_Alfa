import 'package:flutter/material.dart';
import 'package:hue/core/utils/app_colors.dart';
import 'college_detailsbasis_basis.dart';

class UniversitiesPage extends StatelessWidget {
  const UniversitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colleges',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [UniversitiesColors.appBarGradientStart, UniversitiesColors.appBarGradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 10,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [UniversitiesColors.backgroundStart, UniversitiesColors.backgroundEnd],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20, childAspectRatio: 0.8),
            itemCount: colleges.length,
            itemBuilder: (context, index) {
              final college = colleges[index];
              return CollegeCard(college: college);
            },
          ),
        ),
      ),
    );
  }
}

class CollegeCard extends StatelessWidget {
  final Map<String, String> college;
  const CollegeCard({super.key, required this.college});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 5,
      shadowColor: UniversitiesColors.cardShadow.withOpacity(0.3),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CollegeDetailsPage(college: college),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        splashColor: UniversitiesColors.iconShadow.withOpacity(0.2),
        highlightColor: UniversitiesColors.iconShadow.withOpacity(0.1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [UniversitiesColors.cardGradientStart, UniversitiesColors.cardGradientEnd],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: UniversitiesColors.cardShadow.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: college['title']!,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: UniversitiesColors.iconBackground,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: UniversitiesColors.iconShadow.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      college['image']!,
                      width: 80, height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.school, size: 50, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                college['title']!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: UniversitiesColors.textColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Map<String, String>> colleges = [
  {'title': 'AICS', 'image': 'assets/images/AI-CS.png'},
  {'title': 'Fine Arts', 'image': 'assets/images/Fine-arts.png'},
  {'title': 'Physical Therapy', 'image': 'assets/images/physical-therapy.png'},
  {'title': 'Human Medicine', 'image': 'assets/images/Medicine.png'},
  {'title': 'Pharmacy', 'image': 'assets/images/pharmacy.png'},
  {'title': 'Linguistics', 'image': 'assets/images/Al-Alsun.png'},
  {'title': 'Applied Health Sciences', 'image': 'assets/images/Applied-Health-Sciences-Technology.png'},
  {'title': 'Business Admin', 'image': 'assets/images/Business.png'},
  {'title': 'Dentistry', 'image': 'assets/images/dentistry-1.png'},
  {'title': 'Engineering', 'image': 'assets/images/engineering.png'},
];
