import 'package:flutter/material.dart';
import '../../core/utils/assets.dart';
import '../../core/utils/app_colors.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> ads = [
    {'images': Assets.imagesAICS, 'title': 'منح دراسية', 'description': 'تقديم الآن للالتحاق بالمنح الدراسية الدولية'},
    {'images': Assets.imagesAICS, 'title': 'دورات صيفية', 'description': 'سجل في برامجنا الصيفية المكثفة'},
    {'images': Assets.imagesAICS, 'title': 'معرض وظائف', 'description': 'شارك في معرض الوظائف السنوي'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.imagesHUE),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              _buildAdBanner(),
              Expanded(child: _buildAdGrid()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdBanner() {
    return Container(
      height: 100,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(Assets.imagesLogo),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildAdGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.9,
      ),
      itemCount: ads.length,
      itemBuilder: (context, index) => _buildAdItem(ads[index]),
    );
  }

  Widget _buildAdItem(Map<String, dynamic> ad) {
    return GestureDetector(
      onTap: () => print('تم النقر على الإعلان: ${ad['title']}'),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        shadowColor: HomeColors.appBarColor,
        color: HomeColors.adCardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(ad['images'], fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(ad['title'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: HomeColors.adCardTextColor),
                  textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
