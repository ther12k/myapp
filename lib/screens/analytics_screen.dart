import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/transaction.dart';
import '../styles/app_styles.dart';

class AnalyticsScreen extends StatelessWidget {
  final List<Transaction> transactions;

  const AnalyticsScreen({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTotalSpendingCard(),
              const SizedBox(height: 24),
              _buildSpendingCategoryPieChart(),
              const SizedBox(height: 24),
              _buildMonthlySpendingLineChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalSpendingCard() {
    double totalSpending = transactions
        .where((t) => t.amount < 0)
        .fold(0, (sum, t) => sum + t.amount.abs());

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Spending',
              style: AppStyles.subheadingStyle,
            ),
            const SizedBox(height: 8),
            Text(
              '₹${totalSpending.toStringAsFixed(2)}',
              style: AppStyles.headingStyle.copyWith(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpendingCategoryPieChart() {
    Map<String, double> categorySpending = {};
    for (var t in transactions.where((t) => t.amount < 0)) {
      categorySpending[t.title] =
          (categorySpending[t.title] ?? 0) + t.amount.abs();
    }

    List<PieChartSectionData> sections = categorySpending.entries.map((e) {
      return PieChartSectionData(
        color: Colors.primaries[categorySpending.keys.toList().indexOf(e.key) %
            Colors.primaries.length],
        value: e.value,
        title:
            '${e.key}\n${(e.value / categorySpending.values.reduce((a, b) => a + b) * 100).toStringAsFixed(1)}%',
        radius: 100,
        titleStyle: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spending by Category',
              style: AppStyles.subheadingStyle,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlySpendingLineChart() {
    Map<int, double> monthlySpending = {};
    for (var t in transactions.where((t) => t.amount < 0)) {
      int month = t.date.month;
      monthlySpending[month] = (monthlySpending[month] ?? 0) + t.amount.abs();
    }

    List<FlSpot> spots = monthlySpending.entries
        .map((e) => FlSpot(e.key.toDouble(), e.value))
        .toList()
      ..sort((a, b) => a.x.compareTo(b.x));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Spending',
              style: AppStyles.subheadingStyle,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 1:
                              return Text('Jan');
                            case 3:
                              return Text('Mar');
                            case 5:
                              return Text('May');
                            case 7:
                              return Text('Jul');
                            case 9:
                              return Text('Sep');
                            case 11:
                              return Text('Nov');
                            default:
                              return Text('');
                          }
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  minX: 1,
                  maxX: 12,
                  minY: 0,
                  maxY: monthlySpending.values.reduce((a, b) => a > b ? a : b) *
                      1.2,
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: AppStyles.primaryColor,
                      barWidth: 4,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(
                          show: true,
                          color: AppStyles.primaryColor.withOpacity(0.3)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
