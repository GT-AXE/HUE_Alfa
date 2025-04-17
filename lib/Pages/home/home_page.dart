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
          // خلفية الصورة
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
              Expanded(child: _buildAdGrid(context)),
            ],
          ),
        ],
      ),
    );
  }

  // بانر الإعلانات
  Widget _buildAdBanner() {
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        image: DecorationImage(
          image: AssetImage(Assets.imagesLogo),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  // شبكة الإعلانات
  Widget _buildAdGrid(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2, // تغيير الأعمدة بناءً على حجم الشاشة
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: ads.length,
      itemBuilder: (context, index) => _buildAdItem(context, ads[index]),
    );
  }

  // عنصر الإعلان في الشبكة
  Widget _buildAdItem(BuildContext context, Map<String, dynamic> ad) {
    return GestureDetector(
      onTap: () => _onAdTap(ad), // معالجة الضغط على الإعلان
      child: Card(
        elevation: 8, // زيادة الظل قليلاً لإبراز العنصر
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)), // تحسين الزوايا
        shadowColor: HomeColors.appBarColor.withOpacity(0.4),
        color: HomeColors.adCardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.asset(ad['images'], fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                ad['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: HomeColors.adCardTextColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Text(
                ad['description'],
                style: TextStyle(
                  fontSize: 12,
                  color: HomeColors.adCardTextColor.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis, // إضافة خاصية نص قصير
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة التعامل مع الضغط على الإعلان
  void _onAdTap(Map<String, dynamic> ad) {
    print('تم النقر على الإعلان: ${ad['title']}');
    // يمكن إضافة التنقل لصفحة تفاصيل الإعلان هنا
  }
}
