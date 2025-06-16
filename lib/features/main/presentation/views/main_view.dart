import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:med_tech_admin/features/main/presentation/views/widgets/main_view_body.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});
  static const String routeName = '/main';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: MainViewBody());
  }
}

//I will delete this later
//Leave it Do not touch it
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Side Menu

          // Main Dashboard Area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.notifications),
                          SizedBox(width: 16),
                          CircleAvatar(child: Icon(Icons.person)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Stats Cards
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: const [
                      DashboardCard(
                        title: 'Total Revenue',
                        value: '\$245,670',
                        change: '+12.5%',
                        icon: Icons.attach_money,
                        color: Colors.green,
                      ),
                      DashboardCard(
                        title: 'Active Rentals',
                        value: '156',
                        change: '+8.2%',
                        icon: Icons.calendar_today,
                        color: Colors.blue,
                      ),
                      DashboardCard(
                        title: 'Pending Orders',
                        value: '43',
                        change: '-2.1%',
                        icon: Icons.shopping_cart,
                        color: Colors.red,
                      ),
                      DashboardCard(
                        title: 'Maintenance Requests',
                        value: '12',
                        change: '+5.3%',
                        icon: Icons.build,
                        color: Colors.purple,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Revenue Chart and Activity
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Revenue Overview',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 200,
                                  child: RevenueChart(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Recent Activity',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.circle,
                                    color: Colors.blue,
                                    size: 12,
                                  ),
                                  title: Text(
                                    'New order #ORD-2024-001 received',
                                  ),
                                  subtitle: Text('2 minutes ago'),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.circle,
                                    color: Colors.orange,
                                    size: 12,
                                  ),
                                  title: Text(
                                    'Rental contract #RNT-2024-089 expires tomorrow',
                                  ),
                                  subtitle: Text('15 minutes ago'),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                    size: 12,
                                  ),
                                  title: Text(
                                    'Maintenance completed for Equipment #EQP-001',
                                  ),
                                  subtitle: Text('1 hour ago'),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.circle,
                                    color: Colors.red,
                                    size: 12,
                                  ),
                                  title: Text(
                                    'Low stock alert: X-Ray Machine (2 units remaining)',
                                  ),
                                  subtitle: Text('2 hours ago'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final IconData icon;
  final Color color;

  const DashboardCard({
    super.key,
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(icon, color: color),
                ],
              ),
              const SizedBox(height: 4),
              Text(change, style: TextStyle(color: color)),
            ],
          ),
        ),
      ),
    );
  }
}

class RevenueChart extends StatelessWidget {
  const RevenueChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: [
          makeGroupData(0, 70, 40, 10),
          makeGroupData(1, 80, 50, 12),
          makeGroupData(2, 75, 55, 14),
          makeGroupData(3, 90, 60, 16),
          makeGroupData(4, 85, 65, 18),
          makeGroupData(5, 95, 70, 20),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2, double y3) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(toY: y1, color: Colors.blue, width: 8),
        BarChartRodData(toY: y2, color: Colors.green, width: 8),
        BarChartRodData(toY: y3, color: Colors.orange, width: 8),
      ],
    );
  }
}
