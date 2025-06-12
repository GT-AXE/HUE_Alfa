import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ForumsPage extends StatefulWidget {
  const ForumsPage({super.key});

  @override
  State<ForumsPage> createState() => _ForumsPageState();
}

class _ForumsPageState extends State<ForumsPage> {
  bool _isGridView = false;
  bool _isLoading = true;
  bool _isDarkMode = false;
  final List<String> _categories = ['All', 'Tech', 'Study', 'Events', 'Jobs'];
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _forums = [
    {
      'title': 'General Discussion',
      'members': '4.2k',
      'active': '128',
      'icon': Icons.chat_bubble_outline,
      'color': Colors.blue,
      'category': 'All',
      'isTrending': true,
    },
    {
      'title': 'Flutter Developers',
      'members': '3.1k',
      'active': '89',
      'icon': Icons.code_outlined,
      'color': Colors.teal,
      'category': 'Tech',
      'isTrending': true,
    },
    {
      'title': 'Study Groups',
      'members': '3.7k',
      'active': '76',
      'icon': Icons.school_outlined,
      'color': Colors.green,
      'category': 'Study',
      'isTrending': false,
    },
    {
      'title': 'Tech Events',
      'members': '2.9k',
      'active': '54',
      'icon': Icons.event_outlined,
      'color': Colors.orange,
      'category': 'Events',
      'isTrending': true,
    },
    {
      'title': 'Internship Opportunities',
      'members': '1.8k',
      'active': '42',
      'icon': Icons.work_outline,
      'color': Colors.red,
      'category': 'Jobs',
      'isTrending': false,
    },
    {
      'title': 'AI Research',
      'members': '2.5k',
      'active': '67',
      'icon': Icons.mic_outlined,
      'color': Colors.purple,
      'category': 'Tech',
      'isTrending': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
    });
  }

  List<Map<String, dynamic>> get _filteredForums {
    if (_selectedCategory == 'All') return _forums;
    return _forums.where((f) => f['category'] == _selectedCategory).toList();
  }

  List<Map<String, dynamic>> get _trendingForums {
    return _forums.where((f) => f['isTrending']).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'Student ',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.indigo.shade800,
            ),
            children: [
              TextSpan(
                text: 'Community',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.amber.shade300 : Colors.indigo.shade600,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
            icon: Badge(
              smallSize: 8,
              backgroundColor: Colors.amber,
              child: Icon(Icons.notifications_outlined,
                  color: isDark ? Colors.white : Colors.indigo.shade800),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view,
                color: isDark ? Colors.white : Colors.indigo.shade800),
            onPressed: () => setState(() => _isGridView = !_isGridView),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey.shade900,
                    Colors.grey.shade800,
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.indigo.shade50,
                    Colors.white,
                  ],
                ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search forums...',
                  prefixIcon: Icon(Icons.search,
                      color: isDark ? Colors.amber.shade300 : Colors.indigo.shade400),
                  filled: true,
                  fillColor: isDark ? Colors.grey.shade800 : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _selectedCategory = category);
                      },
                      selectedColor: Colors.indigo.shade400,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : 
                              (isDark ? Colors.white : Colors.black),
                      ),
                      backgroundColor: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                    ),
                  );
                }).toList(),
              ),
            ),

            if (_trendingForums.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '🔥 Trending Now',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.amber.shade300 : Colors.indigo.shade800,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See All',
                        style: TextStyle(
                          color: isDark ? Colors.amber.shade300 : Colors.indigo.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (_trendingForums.isNotEmpty)
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _trendingForums.length,
                  itemBuilder: (context, index) {
                    final forum = _trendingForums[index];
                    return _buildTrendingForumCard(forum, isDark);
                  },
                ),
              ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Forums',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.indigo.shade800,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Filter',
                      style: TextStyle(
                        color: isDark ? Colors.amber.shade300 : Colors.indigo.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _isLoading
                  ? _buildLoadingShimmer(isDark)
                  : _isGridView
                      ? _buildGridView(isDark)
                      : _buildListView(isDark),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.indigo.shade600,
        child: const Icon(Icons.add, color: Colors.white),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: isDark ? Colors.grey.shade900 : Colors.white,
        elevation: 8,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.home,
              label: 'Home',
              isSelected: true,
              onTap: () {},
            ),
            _buildNavItem(
              icon: Icons.forum,
              label: 'Forum',
              isSelected: false,
              onTap: () {},
            ),
            _buildNavItem(
              icon: Icons.person,
              label: 'Profile',
              isSelected: false,
              onTap: () {},
            ),
            _buildNavItem(
              icon: Icons.settings,
              label: 'Settings',
              isSelected: false,
              onTap: () {
                setState(() => _isDarkMode = !_isDarkMode);
                Get.changeThemeMode(
                  _isDarkMode ? ThemeMode.dark : ThemeMode.light);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingForumCard(Map<String, dynamic> forum, bool isDark) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showForumSnackbar(forum),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: forum['color'].withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        forum['icon'],
                        color: forum['color'],
                        size: 24,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Trending',
                        style: TextStyle(
                          color: Colors.amber.shade800,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  forum['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.people_outline,
                        size: 16, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(
                      forum['members'],
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.circle,
                        size: 8, color: Colors.green.shade500),
                    const SizedBox(width: 4),
                    Text(
                      '${forum['active']} active',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForumItem(Map<String, dynamic> forum, bool isDark) {
    return Dismissible(
      key: Key(forum['title']),
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.green.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.check, color: Colors.white),
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.indigo.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.bookmark, color: Colors.white),
      ),
      onDismissed: (direction) {
        String action = direction == DismissDirection.startToEnd
            ? 'Joined'
            : 'Bookmarked';
        Get.snackbar(
          '🎉 Success',
          '$action ${forum['title']}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: isDark ? Colors.grey.shade800 : Colors.white,
          colorText: isDark ? Colors.white : Colors.indigo.shade800,
          borderRadius: 12,
          margin: const EdgeInsets.all(16),
          icon: Icon(
            direction == DismissDirection.startToEnd
                ? Icons.people_alt_outlined
                : Icons.bookmark_outline,
            color: Colors.amber.shade300,
          ),
        );
      },
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showForumSnackbar(forum),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade800 : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: forum['color'].withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    forum['icon'],
                    color: forum['color'],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        forum['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.people_outline,
                              size: 16, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            '${forum['members']} members',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.circle,
                              size: 8, color: Colors.green.shade500),
                          const SizedBox(width: 4),
                          Text(
                            '${forum['active']} active',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.indigo.shade900 : Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Join',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.indigo.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer(bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
          highlightColor: isDark ? Colors.grey.shade700 : Colors.grey.shade100,
          child: Container(
            height: 80,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800 : Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    );
  }

  Widget _buildListView(bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredForums.length,
      itemBuilder: (context, index) {
        return _buildForumItem(_filteredForums[index], isDark);
      },
    );
  }

  Widget _buildGridView(bool isDark) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: _filteredForums.length,
      itemBuilder: (context, index) {
        return _buildGridForumItem(_filteredForums[index], isDark);
      },
    );
  }

  Widget _buildGridForumItem(Map<String, dynamic> forum, bool isDark) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _showForumSnackbar(forum),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: forum['color'].withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    forum['icon'],
                    color: forum['color'],
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                forum['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDark ? Colors.white : Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.people_outline,
                      size: 14, color: Colors.grey.shade500),
                  const SizedBox(width: 4),
                  Text(
                    forum['members'],
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isDark ? Colors.indigo.shade900 : Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Join Now',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.indigo.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showForumSnackbar(Map<String, dynamic> forum) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.rocket_launch_outlined,
              color: Colors.amber.shade300,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '🚀 Coming Soon!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.indigo.shade800,
                    ),
                  ),
                  Text(
                    '${forum['title']} forum is launching soon!',
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.indigo.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: isDark ? Colors.grey.shade800 : Colors.white,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(16),
        elevation: 6,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.amber.shade300,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected
                ? isDark ? Colors.amber.shade300 : Colors.indigo.shade600
                : isDark ? Colors.white60 : Colors.grey.shade600,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected
                  ? isDark ? Colors.amber.shade300 : Colors.indigo.shade600
                  : isDark ? Colors.white60 : Colors.grey.shade600,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
