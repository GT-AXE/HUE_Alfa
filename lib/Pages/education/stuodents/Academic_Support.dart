import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          _buildBody(),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 180,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('Academic Support',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 4,
                    color: Colors.black26,
                  )
                ])),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.teal.shade700,
                Colors.indigo.shade500,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  SliverList _buildBody() {
    final supportServices = _getSupportServices();

    return SliverList(
      delegate: SliverChildListDelegate([
        const SizedBox(height: 16),
        _buildQuickActions(),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Available Services',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800)),
        ),
        const SizedBox(height: 16),
        ...supportServices.map((service) => _buildServiceCard(service)).toList(),
        const SizedBox(height: 40),
      ]),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Actions',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.schedule,
                  label: 'Book Session',
                  color: Colors.teal.shade600),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.chat,
                  label: 'Live Chat',
                  color: Colors.indigo.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 20, color: Colors.white),
      label: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 14)),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildServiceCard(SupportService service) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: service.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(service.icon, color: service.color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(service.title,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(service.description,
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12)),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right,
                    color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<SupportService> _getSupportServices() {
    return [
      SupportService(
        'Tutoring Sessions',
        'One-on-one tutoring support with experts',
        Icons.school,
        Colors.teal.shade600,
      ),
      SupportService(
        'Academic Counseling',
        'Personalized advice on courses and study plans',
        Icons.assignment,
        Colors.blue.shade600,
      ),
      SupportService(
        'Career Guidance',
        'Help with career planning and development',
        Icons.work,
        Colors.purple.shade600,
      ),
      SupportService(
        'Research Assistance',
        'Support for your academic research projects',
        Icons.search,
        Colors.orange.shade600,
      ),
      SupportService(
        'Library Services',
        'Access to vast academic resources',
        Icons.library_books,
        Colors.green.shade600,
      ),
    ];
  }
}

class SupportService {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  SupportService(this.title, this.description, this.icon, this.color);
}