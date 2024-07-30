import 'package:flutter/material.dart';
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
              child:
                  Text('No transactions yet.', style: AppStyles.bodyTextStyle))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTotalSpendingCard(),
                    const SizedBox(height: 24),
                    _buildSpendingCategoryChart(),
                    const SizedBox(height: 24),
                    _buildMonthlySpendingChart(),
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
                color: totalSpending > 0 ? Colors.red : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpendingCategoryChart() {
    Map<String, double> categorySpending = {};
    for (var t in transactions.where((t) => t.amount < 0)) {
      categorySpending[t.title] =
          (categorySpending[t.title] ?? 0) + t.amount.abs();
    }

    if (categorySpending.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('No expense categories yet.',
              style: AppStyles.bodyTextStyle),
        ),
      );
    }

    double total = categorySpending.values.reduce((a, b) => a + b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Spending by Category', style: AppStyles.subheadingStyle),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: categorySpending.length,
                itemBuilder: (context, index) {
                  String category = categorySpending.keys.elementAt(index);
                  double amount = categorySpending[category]!;
                  double percentage = amount / total;
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(category),
                          ),
                          Expanded(
                            flex: 7,
                            child: LinearProgressIndicator(
                              value: percentage,
                              color: Colors
                                  .primaries[index % Colors.primaries.length],
                              backgroundColor: Colors.grey[200],
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('${(percentage * 100).toStringAsFixed(1)}%'),
                        ],
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlySpendingChart() {
    Map<int, double> monthlySpending = {};
    for (var t in transactions.where((t) => t.amount < 0)) {
      int month = t.date.month;
      monthlySpending[month] = (monthlySpending[month] ?? 0) + t.amount.abs();
    }

    if (monthlySpending.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('No monthly spending data yet.',
              style: AppStyles.bodyTextStyle),
        ),
      );
    }

    double maxSpending = monthlySpending.values.reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Monthly Spending', style: AppStyles.subheadingStyle),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(12, (index) {
                  int month = index + 1;
                  double spending = monthlySpending[month] ?? 0;
                  double barHeight =
                      maxSpending > 0 ? (spending / maxSpending * 180) : 0;
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: barHeight,
                          color: AppStyles.primaryColor,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          [
                            'J',
                            'F',
                            'M',
                            'A',
                            'M',
                            'J',
                            'J',
                            'A',
                            'S',
                            'O',
                            'N',
                            'D'
                          ][index],
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
