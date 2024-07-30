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
      body: transactions.isEmpty
          ? Center(
              child: Text('No transactions yet. Add some to see analytics!',
                  style: AppStyles.bodyTextStyle))
          : SingleChildScrollView(
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
            Text('Total Spending', style: AppStyles.subheadingStyle),
            const SizedBox(height: 8),
            Text(
              totalSpending > 0
                  ? '₹${totalSpending.toStringAsFixed(2)}'
                  : 'No expenses yet',
              style: AppStyles.headingStyle.copyWith(
                  color: totalSpending > 0 ? Colors.red : Colors.grey),
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

    if (categorySpending.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('No expense data to show category breakdown.',
              style: AppStyles.bodyTextStyle),
        ),
      );
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
            Text('Spending by Category', style: AppStyles.subheadingStyle),
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

    if (monthlySpending.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('No monthly spending data to show chart.',
              style: AppStyles.bodyTextStyle),
        ),
      );
    }

    List<FlSpot> spots = monthlySpending.entries
        .map((e) => FlSpot(e.key.toDouble(), e.value))
        .toList()
      ..sort((a, b) => a.x.compareTo(b.x));

    double maxY = monthlySpending.values.reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Monthly Spending', style: AppStyles.subheadingStyle),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) =>
                            Text('₹${value.toInt()}'),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(fontSize: 10);
                          String text;
                          switch (value.toInt()) {
                            case 1:
                              text = 'Jan';
                              break;
                            case 3:
                              text = 'Mar';
                              break;
                            case 5:
                              text = 'May';
                              break;
                            case 7:
                              text = 'Jul';
                              break;
                            case 9:
                              text = 'Sep';
                              break;
                            case 11:
                              text = 'Nov';
                              break;
                            default:
                              return const SizedBox.shrink();
                          }
                          return Text(text, style: style);
                        },
                      ),
                    ),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  minX: 1,
                  maxX: 12,
                  minY: 0,
                  maxY: maxY * 1.2,
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
